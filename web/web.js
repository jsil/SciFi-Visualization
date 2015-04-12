// var processingCode1 = "../SciFiVis/SciFiVis.pde";
// var processingCode2 = "../SciFiVis/Sphere.pde";
// var jsCode = Processing.compile(processingCode1).sourceCode;
// var jsCode2 = Processing.compile(processingCode2).sourceCode;



var tId,pjs,cnt=0;
$(document).ready(function() {
  pjs = Processing.getInstanceById("canvas1");
  console.log(cnt+':'+pjs);
  if (!pjs) tId=setInterval(function() {
    pjs = Processing.getInstanceById("canvas1");
    console.log(cnt+':'+pjs);
    if (pjs) {
     clearInterval(tId);
  	console.log("here");
  	pjs.setWeb();
  	//pjs.setup();

  	jQuery.get('testData.csv', function(data) {
    var array = CSVToArray(data);
    for (var i = 0; i < array.length; i++) {
    	pjs.addNode(array[i][0],array[i][1],array[i][2],array[i][3],array[i][4]);
    };
});



 }

  },500);




  	function CSVToArray( strData, strDelimiter ){
        // Check to see if the delimiter is defined. If not,
        // then default to comma.
        strDelimiter = (strDelimiter || ",");

        // Create a regular expression to parse the CSV values.
        var objPattern = new RegExp(
            (
                // Delimiters.
                "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +

                // Quoted fields.
                "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +

                // Standard fields.
                "([^\"\\" + strDelimiter + "\\r\\n]*))"
            ),
            "gi"
            );


        // Create an array to hold our data. Give the array
        // a default empty first row.
        var arrData = [[]];

        // Create an array to hold our individual pattern
        // matching groups.
        var arrMatches = null;


        // Keep looping over the regular expression matches
        // until we can no longer find a match.
        while (arrMatches = objPattern.exec( strData )){

            // Get the delimiter that was found.
            var strMatchedDelimiter = arrMatches[ 1 ];

            // Check to see if the given delimiter has a length
            // (is not the start of string) and if it matches
            // field delimiter. If id does not, then we know
            // that this delimiter is a row delimiter.
            if (
                strMatchedDelimiter.length &&
                strMatchedDelimiter !== strDelimiter
                ){

                // Since we have reached a new row of data,
                // add an empty row to our data array.
                arrData.push( [] );

            }

            var strMatchedValue;

            // Now that we have our delimiter out of the way,
            // let's check to see which kind of value we
            // captured (quoted or unquoted).
            if (arrMatches[ 2 ]){

                // We found a quoted value. When we capture
                // this value, unescape any double quotes.
                strMatchedValue = arrMatches[ 2 ].replace(
                    new RegExp( "\"\"", "g" ),
                    "\""
                    );

            } else {

                // We found a non-quoted value.
                strMatchedValue = arrMatches[ 3 ];

            }


            // Now that we have our value string, let's add
            // it to the data array.
            arrData[ arrData.length - 1 ].push( strMatchedValue );
        }

        return( arrData );
    }




	// var canvas = document.getElementById("canvas1");
	// console.log("got canvas: " + canvas.getAttribute("id"));
	// //var p = new Processing(canvas, sketchProc);

	//  var pjs = Processing.getInstanceById("canvas1");
	//  console.log(Processing);


	// var ctx = canvas.getContext('2D');
	//ctx.fillStyle = "#0A0AFF";

	// console.log(canvas.getAttribute("id"));

	// (function() {

	// var pjs = Processing.getInstanceById("canvas1");
	// pjs.background(0);
	// // pjs.exit();

	// }());



});