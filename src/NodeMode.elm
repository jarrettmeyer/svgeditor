module NodeMode exposing (..)


import Vec2 exposing (..)
import Types exposing (..)
import Shape
import Utils
import Set exposing (Set)

select: Int -> Vec2 -> Model -> Model
select ident pos model =
  -- 新規選択
  let
    selected = Set.singleton ident
    selectedRef = List.filter (\e -> Set.member e.id selected) (Utils.getElems model)
  in
  {model|
    selected = selected, selectedRef = selectedRef
  }

noSelect: Model -> Model
noSelect model =
  {model | selected = Set.empty}

-- node modeでノードをクリックしたとき
nodeSelect: Int -> Vec2 -> Model -> Model
nodeSelect nodeId mpos model =
  {model| dragBegin = Just mpos, nodeId = Just nodeId}

-- 選択中のノードがあればそれを移動できる
update: MouseMsg -> Model -> Model
update msg model = case msg of
  MouseMove pos -> case model.nodeId of
    Nothing -> model
    Just nodeId -> case model.dragBegin of
     Nothing -> model
     Just dragBegin ->
      case model.selectedRef of
        [] -> model
        selectedRef :: tl ->
          -- positionにnodeを動かす
          -- selectedRef, selected は handmodeのものを流用
          let
            nodeMoved = Shape.replaceNode nodeId (\pre -> pos -# dragBegin +# pre) selectedRef
            newElems = Utils.replace
              (\elem -> Set.member elem.id model.selected)
              [nodeMoved]
              (Utils.getElems model)
          in
          {model|
            svg = Utils.changeContains newElems model.svg
          }
  MouseUp _ ->
    let
      selectedRef = List.filter (\e -> Set.member e.id model.selected) (Utils.getElems model)
    in
    {model |
      dragBegin = Nothing,
      fixedPoint = Nothing,
      selectedRef = selectedRef
    }
  _ -> model
