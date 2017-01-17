class Resource(object):
    def __init__(self, name, deps=None, specify=False):
        self.name = name
        self.deps = deps or []
        self.specify = specify

    def depends(self, resource):
        self.deps.append(resource)

    def __repr__(self):
        return self.name
