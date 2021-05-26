/-  g=graph-store
/+  shoe, verb, dbug, default-agent, resource, pal
/=  query  /gen/graph-query
::
|%
+$  state-0
  $:  %0
      query-input=gen-input
      posts=(list (list node:g))
  ==
::
+$  gen-input  [=resource:resource search-text=(unit tape) author=(unit @p) before=(unit @da) after=(unit @da) many=_420 ~]
::
::
+$  command
  $%
      [%run-query ~]
      [%select-resource id=@ud]
      [%search-text text=tape]
      [%author author=(unit @p)]
      [%after after=@da]
      [%before before=@da]
  ==
::
+$  card  card:shoe
--
=|  state-0
=*  state  -
::
%+  verb  |
%-  agent:dbug
^-  agent:gall
%-  (agent:shoe command)
^-  (shoe:shoe command)
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    des   ~(. (default:shoe this command) bowl)
    qo    ~(. +> bowl)
::
++  on-init   on-init:def
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  [~ this]
::
++  on-poke   on-poke:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
::
++  command-parser  build-parser:qo
::
++  tab-list  tab-list:des
::
++  on-command
  |=  [sole-id=@ta =command]
  ^-  (quip card _this)
  =^  cards  state
  ?-  -.command
      %run-query  run-query:qo
      ::
      ::
      %select-resource  (put-resource:build-query-generator-input:qo command)
      ::
      %search-text  (put-search-text:build-query-generator-input:qo command)
      ::
      %author  (put-author:build-query-generator-input:qo command)
      ::
      %before  (put-before:build-query-generator-input:qo command)
      ::
      %after  (put-after:build-query-generator-input:qo command)
  ==
  [cards this]
::
++  can-connect
  |=  sole-id=@ta
  ^-  ?
  (team:title [our src]:bowl)
::
++  on-connect
  |=  sole-id=@ta
  ^-  (quip card _this)
  :_  this
  [%shoe [sole-id]~ start:render:qo]~
::
++  on-disconnect   on-disconnect:des
--
::
|_  =bowl:gall
::
++  build-parser
  |=  sole-id=@ta
  ^+  |~(nail *(like [? command]))
  %+  pick
    ;~  pose
      (cold [%run-query ~] (just 'r'))
      (stag %select-resource dem)
    ==
    ::
    ;~  pose
      (stag %search-text ;~(pfix fas (star next)))
      (stag %author ;~(pfix sig (punt fed:ag)))
      (stag %before ;~(pfix (just 'b') (cook |=(i=tape (slav %da (crip i))) (star next))))
      (stag %after ;~(pfix (just 'a') (cook |=(i=tape (slav %da (crip i))) (star next))))
    ==
::
++  run-query
  ^-  (quip card _state)
  :_
    %=  state
          posts
            =<  +
            %-  +:query
            [[now:bowl eny:bowl byk:bowl] query-input.+.state ~]
        ==
  :~
  :+  %shoe  ~
  :+  %sole  %mor
    =-  (turn - (lead %txt))
    ^-  wall
    %-  zing
    %+  turn  posts
    |=  i=(list node:g)
      %+  turn  i
      |=  i=node:g
      =/  text  (get-text-content:destructure-node i)
      ?~  text  ~
      `tape`i.text
  ==
::
++  build-query-generator-input
  |%
    ++  put-resource
      |=  i=[%select-resource @ud]
      ^-  (quip card _state)
      :_  %=  state
                resource.query-input  (~(got by joined-groups-map) +.i)
          ==
        ~
    ++  put-search-text
      |=  i=[%search-text tape]
      ^-  (quip card _state)
      :_  %=  state
                search-text.query-input  `+.i
          ==
        ~
    ++  put-author
      |=  i=[%author (unit @p)]
      ^-  (quip card _state)
      :_  %=  state
                author.query-input  +.i
          ==
        ~
    ++  put-before
      |=  i=[%before @da]
      ^-  (quip card _state)
      :_  %=  state
                before.query-input  `+.i
          ==
        ~
    ++  put-after
      |=  i=[%after @da]
      ^-  (quip card _state)
      :_  %=  state
                after.query-input  `+.i
          ==
        ~
  --
::
++  joined-groups-list
  %~  tap  in
  .^((set resource:resource) %gy /(scot %p our:bowl)/group-store/(scot %da now:bowl)/groups)
::
++  joined-groups-listmap
  (fuse:pal (gulf 1 (lent joined-groups-list)) joined-groups-list)
::
++  joined-groups-map
  (malt joined-groups-listmap)
::
++  destructure-node
  |%
    ++  get-text-content
      |=  i=node:g
      ?>  ?=(%& -.post.i)
      %+  turn  contents.p.post.i
      |=  i=content:g
      ?>  ?=([%text *] i)
      (trip text.i)
  --
::
++  render
  |%
  ::
  ++  start  [%sole %txt "graph-store query. press ? for help (TODO)"]
  ::
  ++  joined-groups
    :+  %sole  %mor
    =-  (turn - (lead %txt))
    ^-  wall
    %+  turn  joined-groups-listmap
    |=  i=[id=@ud =resource:resource]
    "{(scow %ud id.i)}   {(scow %p -.resource.i)}/{(scow %tas +.resource.i)}"
  ::
  --
--
