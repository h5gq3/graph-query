/-  *resource
/+  store=graph-store
|_  =bowl:gall
++  scry-for
  |*  [=mold =path]
  .^  mold
    %gx
    (scot %p our.bowl)
    %graph-store
    (scot %da now.bowl)
    (snoc `^path`path %noun)
  ==
::
++  resource-for-update
  |=  =vase
  ^-  (list resource)
  =/  =update:store  !<(update:store vase)
  ?-  -.q.update
      %add-graph          ~[resource.q.update]
      %remove-graph       ~[resource.q.update]
      %add-nodes          ~[resource.q.update]
      %remove-nodes       ~[resource.q.update]
      %add-signatures     ~[resource.uid.q.update]
      %remove-signatures  ~[resource.uid.q.update]
      %archive-graph      ~[resource.q.update]
      %unarchive-graph    ~
      %add-tag            ~
      %remove-tag         ~
      %keys               ~
      %tags               ~
      %tag-queries        ~
      %run-updates        ~[resource.q.update]
  ==
::
++  upgrade
  |*  [pst=mold out-pst=mold]
  =>
    |%
    ++  orm
      ((ordered-map atom node) gth)
    +$  node
      [post=pst children=internal-graph]
    +$  graph
      ((mop atom node) gth)
    +$  internal-graph
      $~  [%empty ~]
      $%  [%graph p=graph]
          [%empty ~]
      ==
    ::
    ++  out-orm
      ((ordered-map atom out-node) gth)
    +$  out-node
      [post=out-pst children=out-internal-graph]
    +$  out-graph
      ((mop atom out-node) gth)
    +$  out-internal-graph
      $~  [%empty ~]
      $%  [%graph p=out-graph]
          [%empty ~]
      ==
    --

  |=  $:  gra=graph
          fn=$-(pst out-pst)
      ==
  ^-  out-graph
  %-  gas:out-orm
  %+  turn  (tap:orm gra)
  |=  [=atom =node]
  :-  (fn post.node)
  ?:  ?=(%empty -.children.node)
    [%empty ~]
  $(gra p.children.node)
::
++  get-graph
  |=  res=resource
  ^-  update:store
  %+  scry-for  update:store
  /graph/(scot %p entity.res)/[name.res]
::
++  get-graph-mop
  |=  res=resource
  ^-  graph:store
  =/  =update:store
    (get-graph res)
  ?>  ?=(%add-graph -.q.update)
  graph.q.update
::
++  gut-younger-node-siblings
  |=  [res=resource =index:store]
  ^-  (map index:store node:store)
  =+  %+  scry-for  ,=update:store
      %+  weld
        /node-siblings/younger/(scot %p entity.res)/[name.res]/all
      (turn index (cury scot %ud))
  ?>  ?=(%add-nodes -.q.update)
  nodes.q.update
::
++  got-node
  |=  [res=resource =index:store]
  ^-  node:store
  =+  %+  scry-for  ,=update:store
      %+  weld
        /node/(scot %p entity.res)/[name.res]
      (turn index (cury scot %ud))
  ?>  ?=(%add-nodes -.q.update)
  ?>  ?=(^ nodes.q.update)
  q.n.nodes.q.update
::
++  check-node-existence
  |=  [res=resource =index:store]
  ^-  ?
  %+  scry-for  ,?
  %+  weld
    /node-exists/(scot %p entity.res)/[name.res]
  (turn index (cury scot %ud))
::
++  get-update-log
  |=  rid=resource 
  ^-  update-log:store
  %+  scry-for  update-log:store
  /update-log/(scot %p entity.rid)/[name.rid]
::
++  peek-update-log
  |=  res=resource
  ^-  (unit time)
  (scry-for (unit time) /peek-update-log/(scot %p entity.res)/[name.res])
::
++  get-update-log-subset
  |=  [res=resource start=@da]
  ^-  update-log:store
  %+  scry-for  update-log:store
  /update-log-subset/(scot %p entity.res)/[name.res]/(scot %da start)/'~'
::
++  get-keys
  ^-  resources
  =+  %+  scry-for  ,=update:store
      /keys
  ?>  ?=(%keys -.q.update)
  resources.q.update
::
++  tap-deep
  |=  [=index:store =graph:store]
  ^-  (list [index:store node:store])
  %+  roll  (tap:orm:store graph)
  |=  $:  [=atom =node:store]
          lis=(list [index:store node:store])
      ==
  =/  child-index     (snoc index atom)
  =/  childless-node  node(children [%empty ~])
  ?:  ?=(%empty -.children.node)
    (snoc lis [child-index childless-node])
  %+  weld
    (snoc lis [child-index childless-node])
  (tap-deep child-index p.children.node)
::
++  tap-deep-time
  |=  [=index:store =graph:store many=@ud]
  ^-  (list [index:store node:store])
  =/  nodes  (tap:orm:store graph)
  =|  lis=(list [index:store node:store])
  =|  counter=@ud
  |-
  ?~  nodes  lis
  =/  child-index  (snoc index key.i.nodes)
  =/  childless-node  val.i.nodes(children [%empty ~])
  ?:  ?=(%empty -.children.val.i.nodes)
  ?:  =(counter many)  lis
  ^-  (list [index:store node:store])
  $(lis (snoc lis [child-index childless-node]), nodes t.nodes, counter +(counter))
  ^-  (list [index:store node:store])
  %=  $
  lis
    %+  weld
      (snoc lis [child-index childless-node])
    (tap-deep child-index p.children.val.i.nodes)
  nodes  t.nodes
  counter  +(counter)
  ==
::
++  got-deep
  |=  [=graph:store =index:store]
  ^-  node:store
  =/  ind  index
  ?>  ?=(^ index)
  =/  =node:store  (need (get:orm:store graph `atom`i.index))
  =.  ind  t.index
  |-  ^-  node:store
  ?~  ind
    node
  ?:  ?=(%empty -.children.node)
    !!
  %_  $
    ind    t.ind
    node   (need (get:orm:store p.children.node i.ind))
  ==
::
++  get-mark
  |=  res=resource
  (scry-for ,(unit mark) /graph-mark/(scot %p entity.res)/[name.res])
--
