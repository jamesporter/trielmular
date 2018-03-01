module View exposing (..)

import Updates exposing (..)
import Models exposing (..)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Html.Events
import Svg exposing (svg, polygon, circle)
import Svg.Attributes exposing (version, viewBox, points, fill, cx, cy, r)
import Svg.Events exposing (onClick)
import Parameters exposing (height, width)


view : Model -> Html Msg
view model =
    Html.div
        [ style
            [ ( "width", "100%" )
            , ( "height", "100%" )
            , ( "background", "#1f1f1f" )
            , ( "color", "white" )
            , ( "display", "flex" )
            , ( "align-items", "center" )
            , ( "justify-content", "center" )
            , ( "font-family", "Futura" )
            , ( "text-align", "center" )
            ]
        ]
        [ viewDrawing model ]


viewDrawing : Model -> Html Msg
viewGame model =
    Html.div
        [ style [ ( "max-width", "400px" ), ( "min-width", "280px" ), ( "flex", "1" ) ] ]
        [ svg [ version "1.1", viewBox "0 0 400 400" ] viewGrid model]


viewGrid : Model -> List (Html Msg)
viewGrid model =
    List.map (viewGridElement model) (List.range 0 (width * height - 1))  


viewGridElement : Model -> Int -> Html Msg
viewGridElement model idx =
    let
      x = idx % width
      y = idx // height
      triangle = get idx model.triangles
    in          
        rect [ Svg.Attributes.x  (toString (x * 400 // width))
                        , Svg.Attributes.y (toString (y * 400 // height))
                        , Svg.Attributes.width (toString (400 // height))
                        , Svg.Attributes.height (toString (400 // height))
                        , fill "#444"
                        ] []  