+++
title = "Calling Python from Fortran (not the other way around)"
date = 2018-08-20T15:34:41-07:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
categories = []

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `
# Use `caption` to display an image caption.
#   Markdown linking is allowed, e.g. `caption = "[Image credit](http://example.org)"`.
# Set `preview` to `false` to disable the thumbnail in listings.
[header]

caption = ""
preview = true

+++


Python is increasingly becoming the lingua-franca of the machine learning community. Venerable packages like scikit-learn, tensorflow, and pytorch mainly target python users. On the other hand, climate models are typically written in Fortran, for better or worse. How then should we move our python-based machine learning components into the Fortran model? The typical data-sciency answer to this would involve wrapping machine learning method with an HTTP API, perhaps using Flask, but HTTP is probably too slow to use practically within a tightly coupled system like a climate model. Therefore, the alternative would be to call python directly from Fortran, passing the state of the climate model through RAM rather than a high-latency communication layer like HTTP.

Unfortunately, calling python from Fortran flips the typical role of python as a "glue" language on its head. While many alternatives exist for calling Fortran from python, there are many fewer options for the other way around! Calling python from Fortran is known as "embedding" python, but python is not designed to be an embedded language---Lua, another scripting language, is explicitly designed for this.

There are three ways likely ways to possible ways python within a Fortran code:

1. Python's C-API. This is the most general way, but would involve writing a lot of C wrapper code.
2. Cython. Cython is typically used to call C from python, but it is possible to use the other way around.
3. CFFI. This python package has a very convenient feature for embedding python and even devotes a whole page in [their documentation](https://cffi.readthedocs.io/en/latest/embedding.html) describing it.

Regardless of which method is chosen, the user will need to link the Fortran executable to the system python library, for instance by adding a `-lpython3.6` to the Fortran model's Makefile. Without further ado here is a hello world example of calling python from a Fortran program. The Fortran code for this hello world example should be saved in the file `test.f90`:

```fortran
! test.f90
program call_python
  use, intrinsic :: iso_c_binding
  implicit none
  interface
     subroutine hello_world() bind (c)
     end subroutine hello_world
  end interface

  call hello_world()

end program call_python
```

Looking at this code, we can see that it first imports the `iso_c_binding` intrinsic module defined in Fortran 2003 for interoperability with C. While we do not actually need to write any C code when using CFFI, CFFI generates interfaces which c-style binding. The next lines define an interface for a C-function `hello_world`, which could have been implemented in C, but we will instead use python+CFFI. Finally, this function is called.

To implement `hello_world` we build off of CFFI's notation and save the following code to `builder.py`. This script will be used to generate a dynamic library that we can link our Fortran program against:


```python
import cffi
ffibuilder = cffi.FFI()

header = """
extern void hello_world(void);
"""

module = """
from my_plugin import ffi
import numpy as np

@ffi.def_extern()
def hello_world():
    print("Hello World!")
"""

with open("plugin.h", "w") as f:
    f.write(header)

ffibuilder.embedding_api(header)
ffibuilder.set_source("my_plugin", r'''
    #include "plugin.h"
''')

ffibuilder.embedding_init_code(module)
ffibuilder.compile(target="libplugin.dylib", verbose=True)
```

At the top of this module we import the `cffi` package and declare an Foreign-Function-Interface (FFI) object. This may seem contrived, but it is just CFFI's way of doing things.
Next, the `header` string contains a `.h` style header definition of the interface for the function that needs to be called, and the `module` string contains the actually python implementation of this function. 
As we see, the decorator `@ffi.def_extern` is used to mark the hello_world function. The `my_plugin` import at the top of `header` is used to access the `ffi` object, which in addition to the having the `def_extern` decorator, also provides methods for dealing with C types, pointers, and etc.
Then, `ffibuilder.embedding_api(header)` defines the API that the produced library will have, while `embedding_init_code` defines the python code it will contain.
It does seem strange to define python code in a string in this way, but CFFI needs to be able to build this code into a shared library object. There is also a `ffibuilder.set_source` call, which I am embarrassed to say is mystifying to me, but apparently necessary. Anyway...


In any case, to build the shared library `libplugin.dylib` we execute

    python builder.py

Then, we can compile the Fortran program using the following command:

    gfortran -o test -L./ -lplugin test.f90

Note that this might not work on Linux because the file extension expected for shared libraries is `.so` rather than `.dylib`.
If all worked well, we can run the executable using

    $ ./test
    hello world

Hopefully, this clearly demonstrates how to call python from Fortran using CFFI without having to write any C code---except for interface declaration in the string `header`. I will now try to flesh out this basic introduction by answering a series of FAQ style questions.

## Do I have to write all my python code in the string `header`?

No, that would be very annoying. You can easily define some python code in a separate python module (e.g. `my_module.py`), which you can the import at the top of the `module` string. For example, `builder.py` can be modified to show

```python
...

module = """
from my_plugin import ffi
import my_module

@ffi.def_extern()
def hello_world():
    my_module.some_function()

"""
...
```
This code will run provided that `my_module.py` is importable by python, which you can easily check by running `python -c 'import my_module'` from the same working you plan on running the Fortran code from. If this command fails, you will need to add the directory containing `my_module` to python's `sys.path` variable somehow. Describing python's module system is beyond the scope of this article though since this issue is more a python than a Fortran+python issue.

## How do I pass a Fortran array to python?

This [stack overflow page](https://stackoverflow.com/questions/16276268/how-to-pass-a-numpy-array-into-a-cffi-function-and-how-to-get-one-back-out)  answers this question. Here is the punchline. Define this code in a separate module (e.g. `my_module.py`)

```python
# my_module.py

# Create the dictionary mapping ctypes to np dtypes.
ctype2dtype = {}

# Integer types
for prefix in ('int', 'uint'):
    for log_bytes in range(4):
        ctype = '%s%d_t' % (prefix, 8 * (2**log_bytes))
        dtype = '%s%d' % (prefix[0], 2**log_bytes)
        # print( ctype )
        # print( dtype )
        ctype2dtype[ctype] = np.dtype(dtype)

# Floating point types
ctype2dtype['float'] = np.dtype('f4')
ctype2dtype['double'] = np.dtype('f8')


def asarray(ffi, ptr, shape, **kwargs):
    length = np.prod(shape)
    # Get the canonical C type of the elements of ptr as a string.
    T = ffi.getctype(ffi.typeof(ptr).item)
    # print( T )
    # print( ffi.sizeof( T ) )

    if T not in ctype2dtype:
        raise RuntimeError("Cannot create an array for element type: %s" % T)

    a = np.frombuffer(ffi.buffer(ptr, length * ffi.sizeof(T)), ctype2dtype[T])\
          .reshape(shape, **kwargs)
    return a

```

The `asarray` function uses CFFI's `ffi` object to convert the pointer `ptr` to a numpy array with a given shape. It would be called from the `module` string in `builder.py` using

```python

module = """
import my_module

@ffi.def_extern()
def add_one(a_ptr)
    a = my_module.asarray(a_ptr)
    a[:] += 1
"""
```
Just to hammer in the point, add_one could also be defined in `my_module.py`. Finally, we need to define the header corresponding to this function by adding changing the string `header` in `builder.py` to read

```python
header  = """
extern void add_one (double *);
"""
```

Finally, this would be called from Fortran like

```fortran
program call_python
  use, intrinsic :: iso_c_binding
  implicit none
  interface
    subroutine add_one(x_c, n) bind (c)
        use iso_c_binding
        integer(c_int) :: n
        real(c_double) :: x_c(n)
    end subroutine add_one
  end interface
  
  real(c_double) :: x(10)

  print *, x
  call add_one(x, size(x))
  print *, x

end program call_python

```

At this point, we have demonstrated the basic building blocks of embedding python within fortran and passing numerical arrays to/from fortran, however there are some key inconveniences.

## Do I really have to define the signature of any python function in three different places?

Any python function that we want to expose to fortran must be defined in 3 places. First, its C header declaration must be put in `header.h`. Second, its implementation must be defined in the `module` string of `builder.py`---or in an external module as described above. Finally, the fortran code must contain an `interface` block defining the subroutine. This can make it very challenging to change the signature of a python function. For instance, suppose we have written a function
```python
def compute_precipitation(T, Q):
    ...
```
and have declared its signature in all the appropriate places.
If we would like this function to also take the vertical velocity `W` as an input, we would also have to modify the code in `builder.py` and the calling fortran routine.
Obviously, this is extremely tedious, and it would be very difficult to maintain a suite of such functions.

The solution I have started is to implement a very small number of fortran/python wrappers for general purpose communication routines. My current system relies on an external python module:

```python
# module.py
import imp

STATE = {}


def get(key, c_ptr, shape, ffi):
    """Copy the numpy array stored in STATE[key] to a pointer"""

    # wrap pointer in numpy array
    fortran_arr = asarray(ffi, c_ptr, shape)
    
    # update the numpy array in place
    fortran_arr[:] = STATE[key]
    

def set(key, c_ptr, shape, ffi):
    """Call python"""
    STATE[key] = asarray(ffi, c_ptr, shape).copy()


def call_function(module_name, function_name):

    # import the python module
    import importlib
    
    mod = importlib.import_module(module_name)
    
    # the function we want to call
    fun = getattr(mod, function_name)
    
    # call the function
    # this function can edit STATE inplace
    fun(STATE)
```
The global variable `STATE` is a python dictionary that will contain all the necessary data needed by a function. The `get` and `set` functions essentially push fortran arrays into `STATE` and get them out again. If the Fortran/CFFI wrappers are implemented for these three functions, the we can call a python function `cumulus.compute_precipitation(state_dict)` from fortran in the following way:

```fortran
call set("Q", q)
call set("T", temperature)
call set("ahother_arg", 1)

call call_function("cumulus", "compute_precipitation")

call get("prec", prec)
```
All we need to do to pass more data to `compute_precipitation` is to add another `call set` call, and perhaps change the implementation of python function. We _do not_ need to edit any nasty interface statements or the code in `builder.py`.

# Conclusions

I have described a general purpose system for passing fortran data to python functions and retrieving the computed outputs. To avoid editing ugly interface routines more than once, my solution is to push fortran data into a dictionary stored within a python module, call python functions by name which operate on this data and store their outputs in the same dictionary. Then, the fortran code can retrieve the results by referencing the right key in the dictionary. A similar architecture could be used with Cython, but I found CFFI easier to use for several reasons. Most importantly, calling Cython from C requires importing the `Python.h` header file as well as running `Py_initialize` and a `init_my_cython_module` function, whereas CFFI does all this behind the scenes.

The code snippets in this blog post were mostly meant to be illustrative. Some useful things I did not discuss include pushing other fortran data such as characters to python. For more useful code, I have started a GitHub repository https://github.com/nbren12/call_py_fort containing this code. I hope that this project will grow to be something that others can use, and can help make python a modeling tool in addition to a great analysis tool. There is a ton of work to be done. For example, the current code makes several copies of the underlying array, and probably has many bugs. If you are interested in contributing to this project please contact me at [nbren12@uw.edu](mailto:nbren12@uw.edu).

Edit:
- 9/21/2020 Fixed typo in builder2.py script.
