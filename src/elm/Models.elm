module Models exposing (..)
import Array exposing (Array)
import Parameters exposing (..)

type Triangle = Blank | Green | Blue | Yellow | Orange

type Control = Toggle | SetTriangle Triangle

nextColour : Triangle -> Triangle
nextColour tri =
    case tri of
        Blank -> Green
        Green -> Blue
        Blue -> Yellow
        Yellow -> Orange
        Orange -> Blank

type alias Model =
    { triangles : Array Triangle
    , selectedControl: Control
    }

idToCoord: Int -> (Int, Int)
idToCoord i =
    (i % width, i // height)

coordToId: (Int, Int) -> Int
coordToId (x,y) =
    x + y * width
