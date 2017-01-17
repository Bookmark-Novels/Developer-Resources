from deps import bookmark

def _apply_py_(parent, resource):
    obj = {}

    this = parent + '.' + resource.name

    if resource.specify:
        this += '.*'

    for r in resource.deps:
        rkey = this + '.' + r.name

        if r.specify:
            rkey += '.*'

        obj[rkey] = this

    for r in resource.deps:
        subdeps = _apply_py_(this, r)
        obj.update(subdeps)

    return obj

def python():
    obj = {}
    
    for r in bookmark.deps:
        obj.update(_apply_py_('bookmark', r))

    return obj
