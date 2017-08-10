class Resource(object):
    def __init__(self, name, specify=False):
        self.name = name # name of resource
        self.deps = [] # list of things this resource depends on
        self.children = [] # list of this resource's children
        self.parent = None # this resource's parent if any
        self.specify = specify # whether or not this resource requires a specifier ID

    def depends(self, resource):
        self.deps.append(resource)

    def child(self, child):
        self.children.append(child)
        child.parent = self

    def __repr__(self):
        return self.name
