# Test
alias cpptest='g++ main.cpp && oj t -d ./tests'                 # C++
alias pypytest='oj t -c "pypy3 main.py" -d ./tests'             # PyPy3
alias py3test='oj t -c "python3 main.py" -d ./tests'            # CPython

# Submit
alias cppsb='acc s main.cpp'                                    # C++
alias pypysb='acc s main.py -- --guess-python-interpreter pypy' # PyPy3
alias py3sb='acc s main.py'                                     # CPython