module Models exposing (..)
import Array exposing (Array)

type Triangle = Blank | Green | Blue


type alias Model =
    { triangles : Array Triangle
    }
