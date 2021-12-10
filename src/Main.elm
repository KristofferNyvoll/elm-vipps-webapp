module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (Html, button, div, h1, text)
import Html.Attributes
import Html.Events exposing (onClick)



-- MAIN


main : Program () Model Msg
main =
    Browser.element { init = \() -> init, update = update, subscriptions = subscriptions, view = view }


init : ( Model, Cmd Msg )
init =
    ( WaitForLogin, Cmd.none )



-- Model


type alias Model =
    Msg


type Msg
    = Login
    | WaitForLogin



-- UPDATE


gotoVippsLogin : Cmd msg
gotoVippsLogin =
    Browser.Navigation.load "https://www.vg.no/"


update : Msg -> Model -> ( Model, Cmd msg )
update msg _ =
    case msg of
        Login ->
            ( Login, gotoVippsLogin )

        WaitForLogin ->
            ( WaitForLogin, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view _ =
    div
        [ Html.Attributes.style "width" "100%"
        , Html.Attributes.style "align" "center"
        , Html.Attributes.style "display" "flex"
        , Html.Attributes.style "align-items" "center"
        , Html.Attributes.style "height" "150px"
        , Html.Attributes.style "flex-direction" "column"
        , Html.Attributes.style "justify-content" "space-between"
        , Html.Attributes.style "margin-top" "20%"
        ]
        [ h1
            [ Html.Attributes.style "font-family" "sans-serif"
            ]
            [ text "Logg inn med vipps!" ]
        , button
            [ onClick Login
            , Html.Attributes.style "width" "150px"
            , Html.Attributes.style "border-radius" "26px"
            , Html.Attributes.style "height" "50px"
            , Html.Attributes.style "font-family" "sans-serif"
            , Html.Attributes.style "background-color" "#ff5b24"
            , Html.Attributes.style "color" "#ffffff"
            ]
            [ text "Logg inn" ]
        ]
