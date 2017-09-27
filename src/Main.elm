module Main exposing (main)

import Html exposing (Html, program, div, map, header, button, i, text, span, h1, p, footer)
import Html.Attributes exposing (class)
import Chat
import Presentation


fakePresentation =
    { title = "Routing"
    , description = mediumIpsum
    , completed = False
    , groupCompletion = 22
    , codeExamples = fakeCodeExamples
    }


fakeCodeExamples =
    { before =
        [ { filename = "Main.elm"
          , code = mainCodeBefore
          }
        ]
    , after =
        [ { filename = "Main.elm"
          , code = mainCodeAfter
          }
        ]
    }


fakeStudent =
    { firstName = "Josh"
    , lastName = "Graber"
    }


type alias Model =
    { presentation : Presentation.Topic
    , chat : Chat.Model
    }


initModel : Model
initModel =
    { presentation = fakePresentation
    , chat = Chat.initModel fakeStudent
    }


type Msg
    = PresentationMsg Presentation.Msg
    | ChatMsg Chat.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PresentationMsg presentationMsg ->
            let
                ( presentationModel, presentationCmd ) =
                    Presentation.update presentationMsg model.presentation
            in
                ( { model | presentation = presentationModel }
                , Cmd.map PresentationMsg presentationCmd
                )

        ChatMsg chatMsg ->
            let
                ( chatModel, chatCmd ) =
                    Chat.update chatMsg model.chat
            in
                ( { model | chat = chatModel }
                , Cmd.map ChatMsg chatCmd
                )


main =
    program
        { init = ( initModel, Cmd.none )
        , update = update
        , subscriptions = \model -> Sub.none
        , view = view
        }


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ headerView
        , div [ class "content" ]
            [ map ChatMsg <| Chat.view model.chat
            , map PresentationMsg <| Presentation.view model.presentation
            ]
        , footerView
        ]


headerView =
    header [ class "main" ]
        [ h1 [] [ text "More Than a PEEP" ]
        , div [ class "profile" ]
            [ span [ class "name" ] [ text "Blake Thompson" ]
            , button [] [ i [ class "fa fa-fw fa-user" ] [] ]
            , button [] [ i [ class "fa fa-fw fa-hand-paper-o" ] [] ]
            , button [] [ i [ class "fa fa-fw fa-sign-out" ] [] ]
            ]
        ]


footerView =
    footer [ class "main" ]
        [ div []
            [ p [] [ text "Designed by Josh Graber" ]
            , p [] [ text "Free permission to use and modify under MIT license" ]
            ]
        ]


mediumIpsum =
    """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu finibus orci. Etiam id tortor nec erat elementum elementum. Nulla facilisi. Sed blandit fringilla lacus, at mattis nulla egestas non. In cursus faucibus aliquam. Nullam velit nibh, egestas sit amet erat et, tristique tempor risus. Quisque porta blandit ligula eget aliquet. Etiam sollicitudin metus sed risus efficitur, at tempus dui rutrum. Aliquam at quam quam. Duis in porttitor ligula. Sed lacinia, turpis in dapibus posuere, justo tortor pretium elit, vel vulputate leo lacus pellentesque elit. Sed et ullamcorper ligula.

Morbi ac aliquam nulla. Donec sit amet justo eu sapien hendrerit facilisis sit amet vitae mauris. Nam hendrerit justo velit, vel imperdiet ante vestibulum ut. Nullam convallis sem vel eros ultrices, et rhoncus felis rhoncus. Nullam maximus posuere dui sed vestibulum. Pellentesque quis eros quis mauris consequat lobortis. Pellentesque pretium ex sit amet leo sollicitudin, et ultricies odio feugiat. Pellentesque consequat in mi id ultrices.
"""


mainCodeBefore =
    """
module Main exposing (..)

import Html
"""


mainCodeAfter =
    """
module Main exposing(..)

import Html

view model =
    div [] []
"""
