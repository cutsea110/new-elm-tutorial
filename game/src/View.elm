module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Edit
import Players.List
import Players.Models exposing (PlayerId)
import Routing exposing (Route(..))

view : Model -> Html Msg
view model =
    div []
        [page model]

page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            Html.map PlayersMsg (Players.List.view model.players)
        PlayerRoute id ->
            playerEditPage model id
        NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    let maybePlayer =
            model.players
                |> List.filter (\p -> p.id == playerId)
                |> List.head
    in
        case maybePlayer of
            Just p -> Html.map PlayersMsg (Players.Edit.view p)
            Nothing -> notFoundView

notFoundView : Html Msg
notFoundView = div [] [text "Not found"]
