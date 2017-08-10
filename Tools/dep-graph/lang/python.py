import json

from mapper import make_map

def python():
    obj = make_map()
    return 'bookmark_deps = ' + json.dumps(obj, indent=4, sort_keys=True)
