module Chat exposing (Chat, Model, initModel, Msg, update, view)

import Html exposing (Html, section, div, input, form, text, p, span, header)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (onInput, onSubmit)


type alias Student =
    { firstName : String
    , lastName : String
    }


type alias Chat =
    { author : Student
    , content : String
    }


type alias Model =
    { student : Student
    , chats : List Chat
    , chatText : String
    }


initModel student =
    { student = student
    , chats = []
    , chatText = ""
    }


type Msg
    = UpdateChat String
    | SendChat


update msg model =
    case msg of
        UpdateChat newText ->
            ( { model | chatText = newText }, Cmd.none )

        SendChat ->
            let
                chat =
                    { author = model.student
                    , content = model.chatText
                    }

                chats =
                    model.chats ++ [ chat ]
            in
                ( { model | chats = chats, chatText = "" }
                , Cmd.none
                )


view model =
    section [ class "chat-area content-area" ]
        [ form [ onSubmit SendChat ]
            [ chatsView model.chats
            , textView model.chatText
            ]
        ]


chatsView : List Chat -> Html Msg
chatsView chats =
    let
        chatControls =
            chats |> List.map chatView
    in
        div [ class "chats" ] chatControls


chatView : Chat -> Html Msg
chatView chat =
    div [ class "chat" ]
        [ header [] [ authorView chat.author ]
        , p [] [ text chat.content ]
        ]


authorView author =
    let
        authorName =
            author.firstName ++ " " ++ author.lastName
    in
        span [] [ text authorName ]


textView : String -> Html Msg
textView chatText =
    div []
        [ input [ type_ "text", onInput UpdateChat, value chatText ] []
        ]
