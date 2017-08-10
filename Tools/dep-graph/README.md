Small application to automatically generate a resource dependency dictionary for use by Ein. The dictionary is a mapping from dependence to dependent.

## Example

```
> python make_dep_graph.py python

bookmark_deps = {
    "story.*.chapter.*.author": [
        "story.*.chapter.*"
    ],
    "story.*.chapter.*.content": [
        "story.*.chapter.*"
    ],
    "story.*.chapter.*.title": [
        "story.*.toc",
        "story.*.chapter.*"
    ]
}
```
