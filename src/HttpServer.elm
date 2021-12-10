module HttpServer exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Http


type alias Model =
    { result : String
    , errorMessage : Maybe String
    }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick SendHttpRequest ]
            [ text "Get data from server" ]
        , viewResultOrError model
        ]


viewResultOrError : Model -> Html Msg
viewResultOrError model =
    case model.errorMessage of
        Just message ->
            viewError message

        Nothing ->
            viewResult model.result


viewError : String -> Html Msg
viewError errorMessage =
    let
        errorHeading =
            "Couldn't fetch nicknames at this time."
    in
    div []
        [ h3 [] [ text errorHeading ]
        , text ("Error: " ++ errorMessage)
        ]


viewResult : String -> Html Msg
viewResult result =
    div [] [ text ("Result:" ++ result) ]


type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error String)


url : String
url =
    "https://apitest.vipps.no//access-management-1.0/access/.well-known/openid-configuration"


getResult : Cmd Msg
getResult =
    Http.get
        { url = url
        , expect = Http.expectString DataReceived
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( model, getResult )

        DataReceived (Ok res) ->
            let
                results =
                    res
            in
            ( { model | result = results }, Cmd.none )

        DataReceived (Err httpError) ->
            ( { model
                | errorMessage = Just (buildErrorMessage httpError)
              }
            , Cmd.none
            )


buildErrorMessage : Http.Error -> String
buildErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Server is taking too long to respond. Please try again later."

        Http.NetworkError ->
            "Unable to reach server."

        Http.BadStatus statusCode ->
            "Request failed with status code: " ++ String.fromInt statusCode

        Http.BadBody message ->
            message


init : () -> ( Model, Cmd Msg )
init _ =
    ( { result = ""
      , errorMessage = Nothing
      }
    , Cmd.none
    )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
