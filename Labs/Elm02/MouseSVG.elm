module KeyboardExample exposing (..)

import Html as Html
import Platform.Cmd as Cmd
import Platform.Sub as Sub
import Mouse as Mouse
import Svg exposing (..)
import Svg.Attributes exposing (..)

{- Model -}
type alias Model = {
                   position : {x:Int,y:Int}
                   }

init : (Model,Cmd.Cmd Msg)
init = ({ position = {x = 0, y = 0}},Cmd.none)

{- Update -}
type Msg = MouseMsg Mouse.Position

{- Increment / Decrement counter with left and right keys -}
update : Msg -> Model -> (Model,Cmd.Cmd Msg)
update (MouseMsg pos) model = ({position = {x=pos.x, y=pos.y}},Cmd.none)

{- View -}
view : Model -> Html.Html Msg
view model = let
      posX = toString model.position.x
      posY = toString model.position.y
    in svg [width "100%", height "100%"]
        [ellipse [cx posX, cy posY, rx "35", ry "15", fill "blue"] []]

{- Subscriptions -}
subscriptions : Model -> Sub Msg
subscriptions model = Mouse.moves MouseMsg

{- Main -}
main : Program Never Model Msg
main = Html.program
          { init = init,
            view = view,
            update = update,
            subscriptions = subscriptions
            }
