# graph-query

## installation

`rsync -av src/ $URBIT_SHIP_DIR/home/`
or your specified desk instead of `home`

## input arguments

```
resource=resource:g                             ::  group to query from
sq=(unit tape)                                  ::  search query word  :: TODO make case insensitive
author=(unit @p)                                ::  author of post
before=(unit @da)                               ::  cutoff posts after a timepoint
after=(unit @da)                                ::  cutoff posts before a timepoint
many=@ud                                        ::  cutoff value of amount of nodes to query to back in time
```

## example query

`+graph-query [~bitbet-bolbel %urbit-community] ~ `~tinnus-napbus `~2021.4.28 `~2021.4.10 100`
