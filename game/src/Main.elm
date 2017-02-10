module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Navigation exposing (Location)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)


init : Location -> (Model, Cmd Msg)
init loc =
    let currentRoute =
            Routing.parseLocation loc
    in (initialModel currentRoute, Cmd.map PlayersMsg fetchAll)


subs : Model -> Sub Msg
subs model = Sub.none

main : Program Never Model Msg
main = Navigation.program OnLocationChange
       { init = init
       , view = view
       , update = update
       , subscriptions = subs
       }
