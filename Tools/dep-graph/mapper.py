from deps import bookmark

_visited_ = []

def _make_key_(resource):
    k = resource.name

    if resource.specify:
        k += '.*'

    t = [k]
    p = resource.parent

    while p is not None:
        k = p.name

        if p.specify:
            k += '.*'

        t.append(k)
        p = p.parent

    return '.'.join(t[::-1])

def _apply_(resource):
    global _visited_

    obj = {}
    this = _make_key_(resource)

    # we've already visited this resource
    if this in _visited_:
        return

    for r in resource.deps:
        rkey = _make_key_(r)

        # skip "bookmark" dependencies
        # "bookmark" is just a convenient wrapper
        # for everything else...
        if this != 'bookmark':
            if rkey in obj:
                obj[rkey].append(this)
            else:
                obj[rkey] = [this]

        subdeps = _apply_(r)

        for k in subdeps.keys():
            if k in obj:
                obj[k] = obj[k] + subdeps[k]
            else:
                obj[k] = subdeps[k]

    return obj

def make_map():
    global _visited_
    _visited_ = []
    return _apply_(bookmark)