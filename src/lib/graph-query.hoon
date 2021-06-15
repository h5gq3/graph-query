/+  graph-lib=graph
/+  store=graph-store
|_  =bowl:gall
++  tap-deep-time
  |=  [=index:store =graph:store page=@ud]
  ^-  (list [index:store node:store])
  =/  many  420
  =/  nodelist
  =/  nodes  (tap:orm:store graph)
  =|  lis=(list [index:store node:store])
  =|  counter=@ud
  |-
  ?~  nodes  lis
  =/  child-index  (snoc index key.i.nodes)
  =/  childless-node  val.i.nodes(children [%empty ~])
  ?:  ?=(%empty -.children.val.i.nodes)
  ?:  =(counter (mul many page))  lis
  ^-  (list [index:store node:store])
  $(lis (snoc lis [child-index childless-node]), nodes t.nodes, counter +(counter))
  ^-  (list [index:store node:store])
  %=  $
  lis
    %+  weld
      (snoc lis [child-index childless-node])
    (tap-deep:graph-lib child-index p.children.val.i.nodes)
  nodes  t.nodes
  counter  +(counter)
  ==
  ?:  =(page 1)  nodelist
  %+  slag  (mul many (sub page 1))  nodelist
--