module Updates exposing (..)

import Array exposing (Array, get, repeat, set)
import Models exposing (..)
import Parameters exposing (height, width)


type Msg
    = Click Int Int
    | SelectControl Control


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click x y ->
            let
                i =
                    coordToId ( x, y )

                existing =
                    get i model.triangles
            in
                case model.selectedControl of
                    Toggle ->
                        toggleCell i existing model

                    SetTriangle colour ->
                        setCell i colour model

        SelectControl control ->
            ( { model | selectedControl = control }, Cmd.none )


toggleCell : Int -> Maybe Triangle -> Model -> ( Model, Cmd msg )
toggleCell i existing model =
    case existing of
        Just e ->
            let
                next =
                    nextColour e
            in
                ( { model | triangles = set i next model.triangles }, Cmd.none )

        Nothing ->
            ( model, Cmd.none )


setCell : Int -> Triangle -> Model -> ( Model, Cmd msg )
setCell i colour model =
    ( { model | triangles = set i colour model.triangles }, Cmd.none )


initialModel : Model
initialModel =
    { triangles = repeat (width * height) Blank
    , selectedControl = Toggle
    }
