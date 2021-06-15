# graph-query

## installation

`rsync -av src/ $URBIT_SHIP_DIR/home/`
or your specified desk instead of `home`
or from dojo
`|sync %home ~nortex-ramnyd %graph-query`

## generator input arguments

```
resource=resource:g                             ::  group to query from
sq=(unit tape)                                  ::  search query word  :: TODO make case insensitive
author=(unit @p)                                ::  author of post
before=(unit @da)                               ::  cutoff posts after a timepoint
after=(unit @da)                                ::  cutoff posts before a timepoint
page=@ud                                        ::  one page of 420 posts from graph, page 1: queries 420 nodes, page 2: next 420 nodes etc.
```

## example query with generator

``+graph-query [~bitbet-bolbel %urbit-community] ~ `~tinnus-napbus `~2021.4.28 `~2021.4.10 1``

## shoe app usage

make sure to `|commit %home` (or other specified desk) inside dojo and then `|start %graph-query-cli`

then press `?` to see query options
