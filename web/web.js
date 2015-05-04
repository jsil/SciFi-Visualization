function getDimensions() {

    var dimensions = [window.innerWidth, window.innerHeight];
    return dimensions;
}

function hideBar() {
    $("#searchBg").css("display", "none");
    $("#search").css("display", "none");
    console.log("1");
}

function showBar() {
    $("#searchBg").show();
    $("#search").show();
}

function refreshResults() {
    refreshEarth();
    refreshMoon();
    refreshMars();
}

function refreshEarth() {
        pjs.analyzeNodes();
        var nodes = pjs.getEarthNodes();
        var earthSpace = document.getElementById("earthSpace");
        earthSpace.innerHTML = "";
        for (var i = 0; i < nodes.length; i++) {
            var tempElement = document.createElement('div');
            tempElement.className = "searchResult";
            tempElement.innerHTML = "<div class='result'>" + nodes[i].getInfo() + "</div>";
            earthSpace.appendChild(tempElement);
        };

    }

function refreshMoon() {
     pjs.analyzeNodes();
        var nodes = pjs.getMoonNodes();
        var moonSpace = document.getElementById("moonSpace");
        moonSpace.innerHTML = "";
        for (var i = 0; i < nodes.length; i++) {
            var tempElement = document.createElement('div');
            tempElement.className = "searchResult";
            tempElement.innerHTML = "<div class='result'>" + nodes[i].getInfo() + "</div>";
            moonSpace.appendChild(tempElement);
        };
}

function refreshMars() {
     pjs.analyzeNodes();
        var nodes = pjs.getMarsNodes();
        var marsSpace = document.getElementById("marsSpace");
        marsSpace.innerHTML = "";
        for (var i = 0; i < nodes.length; i++) {
            var tempElement = document.createElement('div');
            tempElement.className = "searchResult";
            tempElement.innerHTML = "<div class='result'>" + nodes[i].getInfo() + "</div>";
            marsSpace.appendChild(tempElement);
        };
}

var tId,pjs,cnt=0;
$(document).ready(function() {
  $('#tab-container').easytabs({
     animate: false,
  });
  hideBar();
  pjs = Processing.getInstanceById("canvas1");
  console.log(cnt+':'+pjs);
  if (!pjs) tId=setInterval(function() {
    pjs = Processing.getInstanceById("canvas1");
    console.log(cnt+':'+pjs);
    if (pjs) {
     clearInterval(tId);

     //letting processing "see" javascript
     pjs.bindJavascript(this);

  	
    //TODO: write javascript function overriding setup, so that size can be properly set

  	jQuery.get('pre1969.csv', function(data) {
    var array = CSVToArray(data);
    for (var i = 1; i < array.length; i++) {
        var tags = getTags(array[i][5]);
    	pjs.addNode(array[i][0],array[i][1],array[i][2],array[i][3],array[i][4],tags);
    };
    pjs.analyzeNodes();
    });

    jQuery.get('post1969.csv', function(data) {
    var array2 = CSVToArray(data);
    for (var i = 1; i < array2.length; i++) {
        pjs.addNode(array2[i][0],array2[i][1],array2[i][2],array2[i][3],array2[i][4],getTags(array2[i][5]));
    };
    pjs.analyzeNodes();
    });

    jQuery.get('post1990.csv', function(data) {
    var array3 = CSVToArray(data);
    for (var i = 1; i < array3.length; i++) {
        pjs.addNode(array3[i][0],array3[i][1],array3[i][2],array3[i][3],array3[i][4],getTags(array3[i][5]));
    };
    pjs.analyzeNodes();
    });

    //TODO: access nodeHandler object
    // pjs.countEarthNodes();



    var input = document.getElementById("nodeSearch");

    input.addEventListener('input', function()
    {
        console.log(input.value);
        var nodes = pjs.searchNodes(input.value);
        var searchSpace = document.getElementById("searchSpace");
        searchSpace.innerHTML = "";
        if(input.value != "") {
            for (var i = 0; i < nodes.length; i++) {
                var tempElement = document.createElement('div');
                tempElement.className = "searchResult";
                console.log(nodes[i]);
                tempElement.innerHTML = "<div class='result'>" + nodes[i].getInfo() + "</div>";
                searchSpace.appendChild(tempElement);
            };
        }
    });




 }

  },500);


    $("#earthLink").click(function() {
        refreshEarth();
    });

    $("#moonLink").click(function() {
       refreshMoon();
    });

    $("#marsLink").click(function() {
       refreshMars();
    });


    function getTags(tagString) {
        var tags = new Array();
        if(tagString.indexOf("01") != -1) {
            tags.push(1);
        }
        if(tagString.indexOf("02") != -1) {
            tags.push(2);
        }
        if(tagString.indexOf("03") != -1) {
            tags.push(3);
        }
        if(tagString.indexOf("04") != -1) {
            tags.push(4);
        }
        if(tagString.indexOf("05") != -1) {
            tags.push(5);
        }
        if(tagString.indexOf("10") != -1) {
            tags.push(10);
        }
        if(tagString.indexOf("F") != -1) {
            tags.push(20);
        }
        if(tagString.indexOf("M") != -1) {
            tags.push(21);
        }
        if(tagString.indexOf("30") != -1) {
            tags.push(30);
        }
        if(tagString.indexOf("31") != -1) {
            tags.push(31);
        }
        if(tagString.indexOf("32") != -1) {
            tags.push(32);
        }
        if(tagString.indexOf("33") != -1) {
            tags.push(33);
        }
        if(tagString.indexOf("34") != -1) {
            tags.push(34);
        }
        if(tagString.indexOf("40") != -1) {
            tags.push(40);
        }
        if(tagString.indexOf("41") != -1) {
            tags.push(41);
        }
        if(tagString.indexOf("42") != -1) {
            tags.push(42);
        }
        return tags;
    }



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