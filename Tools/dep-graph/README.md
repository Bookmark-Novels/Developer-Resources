Small application to automatically generate a resource dependency dictionary for use by Ein.

## Example

```
> python make_dep_graph.py python

{'bookmark.story.*.toc': 'bookmark.story.*', 'bookmark.story.*.chapter.*': 'bookmark.story.*', 'bookmark.story.*.toc.chapter.*': 'bookmark.story.*.toc', 'bookmark.story.*.toc.chapter.*.title': 'bookmark.story.*.toc.chapter.*', 'bookmark.story.*.toc.chapter.*.content': 'bookmark.story.*.toc.chapter.*', 'bookmark.story.*.toc.chapter.*.author': 'bookmark.story.*.toc.chapter.*', 'bookmark.story.*.chapter.*.title': 'bookmark.story.*.chapter.*', 'bookmark.story.*.chapter.*.content': 'bookmark.story.*.chapter.*', 'bookmark.story.*.chapter.*.author': 'bookmark.story.*.chapter.*'}
```
