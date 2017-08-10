from .python import python

def js():
    return 'let bookmark_deps = ' + python() + ';'
