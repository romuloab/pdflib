pdflib
======

A LuaJIT FFI binding for the PDFLib 9 library. Please note that PDFLib is a proprietary library and you need a valid license to use it.

To use this library, you need:

1. LuaJIT
2. PDFLib, available at: http://www.pdflib.com/download/pdflib-family/pdflib-9/
3. `g++` and `ar`

First install LuaJIT, then download then PDFLib. Copy the libpdf.a file to the root of this project and execute:

```
$ sh relink_libpdf.sh
```

This will extract all object files from the libpdf.a and then repack them in libpdlibffi.so, exporting all functions to ffi.

Then, to install the pdflib binding, as root:

```
$ cp libpdflibffi.so /usr/lib
$ ln -s `pwd`/pdflib.lua /usr/local/share/lua/5.1/pdflib.lua
```

There are no tests at the moment, but you can try:

```
$ luajit examples/starter_textflow.lua
```

Which will create a starter_textflow.pdf with ~10kb and 4 pages.
