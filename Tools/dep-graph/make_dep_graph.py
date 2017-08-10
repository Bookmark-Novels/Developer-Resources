import sys

from lang.python import python
from lang.js import js
from lang.elixir import elixir

'''
Bookmark utility application for automatically
generating a dictionary mapping dependencies to dependents.
'''
fn = {
    'python': python,
    'js': js,
    'elixir': elixir
}

if len(sys.argv) != 2:
    print('Improper usage. Requires exactly 1 argument.')
    sys.exit(0)
if sys.argv[1] not in fn:
    print('Specified language is not supported.')
    sys.exit(0)

print(fn[sys.argv[1]]())
