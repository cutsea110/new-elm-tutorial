module Main exposing (..)

import Html exposing (Html, program, div, map)
import Widget

-- MODEL

type alias AppModel = { widgetModel : Widget.Model
                      }

initialModel : AppModel
initialModel = { widgetModel = Widget.initialModel }

init : (AppModel, Cmd Msg)
init = (initialModel, Cmd.none)

-- MESSAGE

type Msg = WidgetMsg Widget.Msg

-- VIEW

view : AppModel -> Html Msg
view model = div [] [ map WidgetMsg (Widget.view model.widgetModel)
                    ]

-- UPDATE

update : Msg -> AppModel -> (AppModel, Cmd Msg)
update msg model =
    case msg of
        WidgetMsg subMsg ->
            let (updatedWidgetModel, widgetCmd) =
                    Widget.update subMsg model.widgetModel
            in ({model | widgetModel = updatedWidgetModel}, Cmd.map WidgetMsg widgetCmd)

-- SUBSCRIPTION

subs : AppModel -> Sub Msg
subs model = Sub.none

-- APP

main : Program Never AppModel Msg
main = program { init = init
               , view = view
               , update = update
               , subscriptions = subs
               }
