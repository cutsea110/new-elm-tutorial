module Main exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard

-- MODEL

type alias Model = Int

init : (Model, Cmd Msg)
init = (0, Cmd.none)

-- MESSAGE

type Msg = MouseMsg Mouse.Position | KeyMsg Keyboard.KeyCode

-- VIEW

view : Model -> Html Msg
view model = div [] [text (toString model)]

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        MouseMsg pos -> (model + 1, Cmd.none)
        KeyMsg cd -> (model + 2, Cmd.none)

-- SUBSCRIPTION

subs : Model -> Sub Msg
subs model =
    Sub.batch [ Mouse.clicks MouseMsg
              , Keyboard.downs KeyMsg
              ]

-- MAIN

main : Program Never Model Msg
main = program { init = init
               , view = view
               , update = update
               , subscriptions = subs
               }
