import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
--import Html.App as Html
--import Html.Events exposing (..)
import Keyboard
import Time exposing (..)
import Element exposing (..)
import Collage exposing (..)
import Color exposing (..)
import Text
import Char
import Random exposing (..)
import Tuple

-- Retrieving Model aspects
import ModelS exposing (..)

-- Constants
snakePieceDim = 15
berryRadius = 7.5
(width,height) = (600,600)

main =
    Html.program
      { init = init
      , view = view
      , subscriptions = subscriptions
      , update = update }

type Msg =
      Tick Time
    | KeyPress Keyboard.KeyCode
    | Spawn (Float,Point)
    | Difficulty ModelS.Difficulty

-- Random Point generator for randomizing Berry spawns
randPoint = Random.pair (Random.float 0 1) (Random.float 0 1)

generator : Random.Generator (Float,Point)
generator = Random.pair (Random.float 0 1) randPoint

-- Initial states of the app
initSnake : Snake
initSnake = let
      front = (0,0)
      back = List.map (\n -> pos (-n*snakePieceDim) 0) [1,2,3,4,5,6,7,8]
  in { front = front, back = back, direction = Right }

init : (Model,Cmd Msg)
init = let
      model = TitleScreen
  in (model,Cmd.none)

-- Definfing Subscriptions with Alternations to original source code
subscriptions : Model -> Sub Msg
subscriptions model = case model of
    Initializing _ ->
      Keyboard.presses KeyPress

    Playing _ _ _ _ ->
      Sub.batch
        [ Keyboard.presses KeyPress
        , Time.every (Time.inMilliseconds 50) Tick
        ]

    GameOver _ ->
      Keyboard.presses KeyPress

    _ ->
      Sub.none

view : Model -> Html Msg
view model = let
      wrapper = (\body -> div [] [ headerView, body ] )
  in case model of
      TitleScreen -> wrapper ( titleView model )
      Initializing _ -> wrapper ( gameView model )
      Playing _ _ _ _ -> wrapper ( gameView model )
      GameOver _ -> wrapper ( gameView model)

headerView : Html Msg
headerView = div [ class "container" ]
                [
                header []
                  [ h1 [] [ Html.text "Snake" ]
                  , h4 [] [ Html.text "Made By: Akram Elwazani" ]
                  ]
                ]

titleView : Model -> Html Msg
titleView model = div [ class "container" ]
                    [ button [ onClick (Difficulty Easy) ] [ Html.text "Easy" ]
                    ,  button [ onClick (Difficulty Normal) ] [ Html.text "Normal" ]
                    ,  button [ onClick (Difficulty Hard) ] [ Html.text "Hard" ]
                    ]

gameView : Model -> Html Msg
gameView model = let
        bg = rect (toFloat width) (toFloat height)|> filled black
        content = case model of
                  Initializing _ ->
                    [ txt "press SPACE to start\n[w, a, s, d] controls snake" ]

                  GameOver score ->
                    [ txt "\n\nGAME OVER", txt (toString score) ]

                  Playing snake berry score _ ->
                    let
                        front = rect snakePieceDim snakePieceDim |> filled yellow |> move snake.front
                        back = snake.back
                          |> List.map (\pos -> rect snakePieceDim snakePieceDim
                          |> filled green
                          |> move pos)
                        scoreL = txt (toString score)
                      in case berry of
                          Nothing -> scoreL :: front :: back
                          Just pos ->
                            (circle berryRadius
                            |> filled red
                            |> move pos) :: scoreL :: front :: back

                  _ ->
                    [ txt "error" ]

      in collage width height (bg :: content)
          |> Element.toHtml

update : Msg -> Model -> (Model,Cmd Msg)
update msg model = case model of
      TitleScreen ->
        case msg of
          Difficulty Easy ->
            (Initializing Easy,Cmd.none)

          Difficulty Normal ->
            (Initializing Normal,Cmd.none)

          Difficulty Hard ->
            (Initializing Hard,Cmd.none)

          _ ->
            (model,Cmd.none)

      Initializing diff ->
        case msg of
          KeyPress 32 ->
            (Playing initSnake Nothing 0 diff, Cmd.none)

          _ ->
            (model,Cmd.none)

      GameOver _ ->
        case msg of
          KeyPress 32 ->
            (TitleScreen, Cmd.none)

          _ ->
            (model,Cmd.none)

      Playing snake berry score diff ->
        case msg of
          KeyPress keyCode -> let
              newDir = getNewDirection keyCode snake.direction
              newSnake = { snake | direction = newDir }
            in (Playing newSnake berry score diff, Cmd.none)

          Spawn (chance, (randX, randY) ) ->
            if chance <= 0.1 then
              let
                newBerry = spawnBerry randX randY
              in (Playing snake newBerry score diff, Cmd.none)
            else
              (model, Cmd.none)

          Tick _ ->
            case diff of
              Easy ->
                  let
                    newFront = getNewSegmentEasy snake.front snake.direction
                    ateBerry = case berry of
                      Just pos -> isOverlap newFront pos
                      Nothing -> False
                    newBack = if ateBerry then
                        snake.front :: snake.back
                      else
                        snake.front :: (List.take (List.length snake.back-1) snake.back)
                    newSnake = { snake | front = newFront, back = newBack }
                    (newBerry, newScore) =
                      if ateBerry then
                        (Nothing, score + 1)
                      else
                        (berry, score)
                    gameOver = isGameOver newFront newBack
                in if gameOver then
                    (GameOver newScore, Cmd.none)
                  else if newBerry == Nothing then
                    (Playing newSnake newBerry newScore diff, Random.generate Spawn generator)
                  else
                    (Playing newSnake newBerry newScore diff, Cmd.none)

              Normal ->
                  let
                    newFront = getNewSegmentNormal snake.front snake.direction
                    ateBerry = case berry of
                      Just pos -> isOverlap newFront pos
                      Nothing -> False
                    newBack = if ateBerry then
                        snake.front :: snake.back
                      else
                        snake.front :: (List.take (List.length snake.back-1) snake.back)
                    newSnake = { snake | front = newFront, back = newBack }
                    (newBerry, newScore) =
                        if ateBerry then
                          (Nothing, score + 1)
                        else
                          (berry, score)
                    gameOver = isGameOver newFront newBack
                in if gameOver then
                    (GameOver newScore, Cmd.none)
                  else if newBerry == Nothing then
                    (Playing newSnake newBerry newScore diff, Random.generate Spawn generator)
                  else
                    (Playing newSnake newBerry newScore diff, Cmd.none)

              Hard ->
                  let
                    newFront = getNewSegmentHard snake.front snake.direction
                    ateBerry = case berry of
                      Just pos -> isOverlap newFront pos
                      Nothing -> False
                    newBack = if ateBerry then
                        snake.front :: snake.back
                      else
                        snake.front :: (List.take (List.length snake.back-1) snake.back)
                    newSnake = { snake | front = newFront, back = newBack }
                    (newBerry, newScore) =
                      if ateBerry then
                        (Nothing, score + 1)
                      else
                        (berry, score)
                    gameOver = isGameOver newFront newBack
                in if gameOver then
                    (GameOver newScore, Cmd.none)
                  else if newBerry == Nothing then
                    (Playing newSnake newBerry newScore diff, Random.generate Spawn generator)
                  else
                    (Playing newSnake newBerry newScore diff, Cmd.none)

          _ ->
            (model,Cmd.none)

txt : String -> Form
txt msg =
  msg
  |> Text.fromString
  |> Text.color green
  |> Text.monospace
  |> Element.centered
  |> Collage.toForm

getNewDirection : Char.KeyCode -> ModelS.Direction -> ModelS.Direction
getNewDirection keyCode currentDir =
  let (changeableDirs, newDir) =
    case Char.fromCode keyCode of
      'a' -> ([ Up, Down ], Left)
      'w' -> ([ Left, Right ], Up)
      'd' -> ([ Up, Down ], Right)
      's' -> ([ Left, Right ], Down)
      _  -> ([], currentDir)
  in if List.any ((==) currentDir) changeableDirs then newDir else currentDir

getNewSegmentEasy : Point -> ModelS.Direction -> Point
getNewSegmentEasy (x, y) direction =
  case direction of
    Up    -> pos x (y+snakePieceDim/3)
    Down  -> pos x (y-snakePieceDim/3)
    Left  -> pos (x-snakePieceDim/3) y
    Right -> pos (x+snakePieceDim/3) y

getNewSegmentNormal : Point -> ModelS.Direction -> Point
getNewSegmentNormal (x, y) direction =
  case direction of
    Up    -> pos x (y+snakePieceDim/1.5)
    Down  -> pos x (y-snakePieceDim/1.5)
    Left  -> pos (x-snakePieceDim/1.5) y
    Right -> pos (x+snakePieceDim/1.5) y

getNewSegmentHard : Point -> ModelS.Direction -> Point
getNewSegmentHard (x, y) direction =
  case direction of
    Up    -> pos x (y+snakePieceDim)
    Down  -> pos x (y-snakePieceDim)
    Left  -> pos (x-snakePieceDim) y
    Right -> pos (x+snakePieceDim) y

isGameOver : Point -> List Point -> Bool
isGameOver newFront newBack =
  List.any ((==) newFront) newBack   -- eat itself
  || Tuple.first newFront > (width / 2)      -- hit bottom
  || Tuple.second newFront > (height / 2)     -- hit top
  || Tuple.first newFront < (-width / 2)     -- hit left
  || Tuple.second newFront < (-height / 2)    -- hit right

spawnBerry : Float -> Float -> Berry
spawnBerry randW randH =
  let x = randW * width - width / 2
      y = randH * height - height / 2
  in pos x y |> Just

isOverlap : Point -> Point -> Bool
isOverlap (snakeX, snakeY) (berryX, berryY) =
  let (xd, yd) = (berryX - snakeX, berryY - snakeY)
      distance = sqrt(xd * xd + yd * yd)
  in distance <= (berryRadius * 2)
