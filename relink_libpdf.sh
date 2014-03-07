ar -x libpdf.a
g++ -shared -o libpdflibffi.so *.{ao,o}
rm *.{ao,o}
