module Presentation exposing (..)

import Html exposing (div, section, text, h2, h3, input, label, aside, p)
import Html.Attributes exposing (class, type_, for, id)


type alias Topic =
    { title : String
    , description : String
    , completed : Bool
    , groupCompletion : Int
    , codeExamples : CodeExamples
    }


type alias CodeExamples =
    { before : List CodeExample
    , after : List CodeExample
    }


type alias CodeExample =
    { filename : String
    , code : String
    }


type Msg
    = ToggleCompleted


update msg model =
    case msg of
        ToggleCompleted ->
            ( { model | completed = not model.completed }, Cmd.none )


view model =
    section [ class "presentation-area content-area" ]
        [ h2 [] [ text model.title ]
        , p [ class "description" ] [ text model.description ]
        , progressView model
        , codeExamplesView model.codeExamples
        ]


progressView model =
    aside [ class "progress-area" ]
        [ div [ class "checkbox" ]
            [ label [ for "done" ] [ text "DONE" ]
            , input [ type_ "checkbox", id "done" ] []
            ]
        , div [ class "group-progress" ]
            [ label [] [ text "Group completion" ]
            ]
        ]


codeExamplesView codeExamples =
    div [ class "code-examples" ]
        [ h3 [] [ text "Code Examples" ]
        ]
