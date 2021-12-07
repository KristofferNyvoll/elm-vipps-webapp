module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, text)
import Html.Attributes
import Html.Events exposing (onClick)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Login


update : Msg -> Model -> Model
update msg model =
    case msg of
        Login ->
            model + 1



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ Html.Attributes.style "width" "100%"
        , Html.Attributes.style "align" "center"
        ]
        [ h1
            [ Html.Attributes.style "margin" "auto"
            , Html.Attributes.style "text-align" "center"
            ]
            [ text "Logg inn med vipps!" ]
        , button [ onClick Login ] [ text "Logg inn" ]
        ]
