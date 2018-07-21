module View exposing (..)

import Updates exposing (..)
import Models exposing (..)
import Html exposing (Html, text, h1, a)
import Html.Attributes exposing (style, class, classList)
import Html.Events
import Svg exposing (svg, polygon)
import Svg.Attributes exposing (version, viewBox, points, fill)
import Svg.Events exposing (onClick)
import Parameters exposing (height, width, delta)
import Array exposing (get)


view : Model -> Html Msg
view model =
    Html.div
        [ style [ ( "user-select", "none" ) ] ]
        [ viewDrawing model
        , h1 [ class "title", style [ ( "user-select", "none" ) ] ] [ text "Trielmular" ]
        , viewControls model
        ]


viewDrawing : Model -> Html Msg
viewDrawing model =
    Html.div
        [ class "drawing" ]
        [ svg [ version "1.1", viewBox "0 0 21 20" ] (viewGrid model) ]


viewGrid : Model -> List (Html Msg)
viewGrid model =
    List.map (viewGridElement model) (List.range 0 (width * height - 1))


viewGridElement : Model -> Int -> Html Msg
viewGridElement model idx =
    let
        ( x, y ) =
            idToCoord idx

        triangle =
            get idx model.triangles
    in
        polygon [ points (polyPath ( x, y )), fill (fillColour triangle), onClick (Click x y) ] []


polyPath : ( Int, Int ) -> String
polyPath ( a, b ) =
    let
        ( x, y ) =
            ( toFloat a, toFloat b )
    in
        if (a + b) % 2 == 0 then
            coordsToString [ ( x + 1, y ), ( x + delta, y + 1 - delta ), ( x + 2 - delta, y + 1 - delta ) ]
        else
            coordsToString [ ( x + delta, y ), ( x - delta + 2, y ), ( x + 1, y + 1 - delta ) ]


availableControls : List ( String, Control )
availableControls =
    [ ( "Toggle", Toggle )
    , ( "Green", SetTriangle Green )
    , ( "Yellow", SetTriangle Yellow )
    , ( "Blue", SetTriangle Blue )
    , ( "Clear", SetTriangle Blank )
    ]


viewControls : Model -> Html Msg
viewControls model =
    Html.div [ class "controls" ] (List.map (control model.selectedControl) availableControls)


control: Control -> ( String, Control) -> Html Msg
control current (name, ctrl) =
    let 
        selected = ctrl == current 
    in 
        a [ Html.Events.onClick (SelectControl ctrl), classList [("control", True), ("selected", selected)]] [ text name ]




coordsToString : List ( number, number ) -> String
coordsToString coords =
    coords
        |> List.map (\( x, y ) -> (toString x) ++ "," ++ (toString y))
        |> String.join " "


fillColour : Maybe Triangle -> String
fillColour triangle =
    case triangle of
        Just t ->
            case t of
                Blank ->
                    "#5C6376"

                Yellow ->
                    "#E5AF3C"

                Green ->
                    "#94CE54"

                Blue ->
                    "#77B3C9"

                Orange ->
                    "#ee6600"

        Nothing ->
            "#3B404C"
