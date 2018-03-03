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
            let 
                i = coordToId (x,y)
                existing = get i model.triangles
            in
                case existing of
                    Just e -> let next = nextColour e in ({model | triangles = set i next model.triangles }, Cmd.none)
                    Nothing -> (model, Cmd.none)

initialModel : Model
initialModel =
    { triangles = repeat (width * height) Blank
    }