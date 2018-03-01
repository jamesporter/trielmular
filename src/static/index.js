// pull in styl
require( './styles/main.styl' );

// inject bundled Elm app into div#main
var Elm = require( '../elm/Drawing' );
Elm.Drawing.embed( document.getElementById( 'main' ) );
