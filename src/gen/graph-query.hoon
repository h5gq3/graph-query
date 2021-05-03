/-  g=graph-store
/-  metadata=metadata-store
/+  gra=graph-query

:-  %say
|=  $:  [now=@da * bec=beak]
        $:
        resource=resource:g                             ::  group to query from
        sq=(unit tape)                                  ::  search query word  :: TODO make case insensitive
        author=(unit @p)                                ::  author of post
        before=(unit @da)                               ::  cutoff posts after a timepoint
        after=(unit @da)                                ::  cutoff posts before a timepoint
        many=@ud                                        ::  cutoff value of amount of nodes to query to back in time
        ~
        ==
        ~
    ==
:-  %noun
=*  our  p.bec
|^
channel-reducer
::
+$  query-filter  (unit $-(node:g ?(~ [~ node:g])))
::
++  get-nodes
  |=  [ship=@p name=cord]
  =/  graph-srcy  .^(update:g %gx /(scot %p our)/graph-store/(scot %da now)/graph/(scot %p ship)/(scot %tas name)/noun)
  =/  graph
  ?>  ?=([%add-graph *] q.graph-srcy)  graph.q.graph-srcy
  (tap-deep-time:gra [*index:g graph many])
::
++  get-text-content
  |=  c=content:g
  ?.(?=([%text *] c) ~ `c)
::
++  get-match
  |=  c=content:g
  =/  gah2  (mask ~[`@`10 `@`9 ' '])
  ?>  ?=([%text *] c)
  =/  search
  %+  skim
  `wall`(rash text.c (more gah2 (star ;~(less gah2 prn))))        :: tokenize text and skip nulls
  |=(i=tape =(i (need sq)))
  ?~  search  ~
  `c
::
++  matched-contents-reducer
  |=  i=node:g
  ?>  ?=(%& -.post.i)
  %+  reel
  (limo ~[get-match get-text-content])
  |=  [f=$-(content:g ?(~ [~ content:g])) l=_contents.p.post.i]
  (murn l f)
::
++  query-reducer
  |=  [ship=@p name=cord]
  =/  search-f=query-filter  ?~(sq ~ `|=(i=node:g ?.(!=(~ (matched-contents-reducer i)) ~ `i)))
  =/  author-f=query-filter  ?~(author ~ `|=(i=node:g ?.(=((need author) ?>(?=(%& -.post.i) author.p.post.i)) ~ `i)))
  =/  before-f=query-filter  ?~(before ~ `|=(i=node:g ?.((lth ?>(?=(%& -.post.i) time-sent.p.post.i) (need before)) ~ `i)))
  =/  after-f=query-filter  ?~(after ~ `|=(i=node:g ?.((gth ?>(?=(%& -.post.i) time-sent.p.post.i) (need after)) ~ `i)))
  =/  composite-f=(list $-(node:g ?(~ [~ node:g])))
  %+  murn
  `(list query-filter)`~[search-f after-f before-f author-f]
  |=(i=query-filter ?~(i ~ i))
  ::
  %+  reel
  composite-f
  |=  [f=$-(node:g ?(~ [~ node:g])) l=_(turn (get-nodes [ship name]) |=(i=[p=index:g q=node:g] q.i))]
  (murn l f)
::
++  channel-reducer
  =/  group-channels  .^(associations:metadata %gx /(scot %p our)/metadata-store/(scot %da now)/app-name/graph/noun)
  =/  joined-channels  q:.^(update:g %gx /(scot %p our)/graph-store/(scot %da now)/keys/noun)
  ?>  ?=([%keys *] joined-channels) 
  %+  skip
  %+  turn  ~(tap by group-channels)
  |=  i=[p=md-resource:metadata q=association:metadata]
  ?.  ?&  =([entity.group.q.i name.group.q.i] resource)
          (~(has in resources.joined-channels) resource.p.i)
      ==
      ~
  (query-reducer [entity.resource.p.i `cord`name.resource.p.i])
  |=  i=*
  =(~ i)
--
