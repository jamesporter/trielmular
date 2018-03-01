module Updates exposing (..)

import Models exposing (..)
import Parameters exposing (width, height)
import Array exposing (Array, get, set, repeat)

type Msg
    = Click Int Int
    
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click x y ->
            (model, Cmd.none)

initialModel : Model
initialModel =
    { triangles = repeat (width * height) Blank
    }