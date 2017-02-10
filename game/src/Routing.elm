module Routing exposing (..)

import Navigation exposing (Location)
import Players.Models exposing (PlayerId)
import UrlParser exposing (..)

type Route = PlayersRoute
           | PlayerRoute PlayerId
           | NotFoundRoute

matchers : Parser (Route -> a) a
matchers = oneOf
           [ map PlayersRoute top
           , map PlayerRoute (s "players" </> string)
           , map PlayersRoute (s "players")
           ]

parseLocation : Location -> Route
parseLocation loc =
    case (parseHash matchers loc) of
        Just route -> route
        Nothing -> NotFoundRoute
