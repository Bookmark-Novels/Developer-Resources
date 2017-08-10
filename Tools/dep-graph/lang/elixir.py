import textwrap

from mapper import make_map

def _e_tuple_(l):
    return '{' + ', '.join(map(lambda x: '"{}"'.format(x), l)) + '}'

def elixir():
    obj = make_map()

    ret = '''
    use Mix.Config

    config :bookmark_deps,
        map: %({})
    '''

    l = []

    for k in obj.keys():
        l.append('"{}" => {}'.format(k, _e_tuple_(obj[k])))

    ret = textwrap.dedent(ret).strip()
    ret = ret.format(', '.join(l))

    return ret