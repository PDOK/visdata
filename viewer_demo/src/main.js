var mapboxgl = require('mapbox-gl');
var scrollama = require('scrollama');
var d3 = require('d3');
var typeahead = require("typeahead.js");
var Bloodhound = require("bloodhound-js");
var $ = require("jquery");


mapboxgl.accessToken =  "pk.eyJ1IjoibmllbmViIiwiYSI6IlR6NWEzdmMifQ.dRVGdAluvTb9EIXVBREbzw";

var bounds = [
    [2.59326, 50.72915], // Southwest coordinates
    [8.85636, 54.76957]  // Northeast coordinates
];



var myStyles = [
    "./styles/achtergrond.json", 
    "./styles/data.json",
    "./styles/purple.json",
    "./styles/roads.json"
];

var myDataSets = [
    ['BGT', 17],
    ['TOP10NL', 14 ],
    ['TOP50NL', 12 ],
    ['TOP100NL', 10 ],
    ['TOP250NL', 8 ],
    ['TOP500NL', 6 ],
    ['TOP1000NL', 5 ]
];

var colors = [
    '#ffffcc',
    '#a1dab4',
    '#41b6c4',
    '#2c7fb8',
    '#253494',
    '#fed976',
    '#feb24c',
    '#fd8d3c',
    '#f03b20',
    '#bd0026',
    '#474747',
    '#f9f9f9'
];

var i = 0;


// MAP OPTIONS
var options = {
    container: "map",
    hash: true,
    style: myStyles[i],
    zoom: 8,
    pitch: 0,
    bearing: 0,
    center: [5.19,52.33],
    attributionControl: false
}

// INITIALIZE MAP
var map = new mapboxgl.Map(options);
map.addControl(new mapboxgl.AttributionControl(), "bottom-left");

// MOBILE 
document.addEventListener('touchmove', function(event) {
     event.preventDefault();
}, false);

// NO CONTROLS WHEN PHONE!
if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
  document.getElementById('search_bar').style.left = '10px';
  // MAP TOUCH EVENT
  map.touchZoomRotate.enable();
  map.touchZoomRotate.enable({ around: 'center' });
  map.touchZoomRotate.enableRotation();
} else { 
  map.addControl(new mapboxgl.NavigationControl(), 'top-left'); 
  // MAP MOUSE EVENT
  map.scrollZoom.enable();
  map.scrollZoom.enable({ around: 'center' })
  map.dragPan.enable();
  map.dragRotate.enable();
  map.doubleClickZoom.enable();
};


// GETTING DOCUMENT ELEMENTS
var opties = document.getElementById('opties');
var swatches = document.getElementById('swatches');
var orignial_id = document.getElementById('orignial_id');
var current_zoom = document.getElementById('current_zoom');
// using d3 for convenience, and storing a selected elements
var container = d3.select('#scroll');
var graphic = container.select('.scroll__graphic');
var text = container.select('.scroll__text');
var step = text.selectAll('.step');


//STEP 1 - switch bewteen styles
var click = 0;
document.getElementById('switch').addEventListener('click', switchStyle);
function switchStyle(){
  if ( click < (myStyles.length-1)){ 
    click += 1;
    map.setStyle(myStyles[click], {diff:true});
  } else {
    click = 0;
    map.setStyle(myStyles[click], {diff:true});
  };
};


// STEP 2. LABELS TOGGLE ON OFF
var click2 = 0;
var toggleableLayerIds = ['labels', 'labels_roads_top10', 'building_labels', 'water_labels', 'labels_highway'];

document.getElementById('toggle').addEventListener('click', toggleOnOff);
function toggleOnOff(){
    var visibility = map.getLayoutProperty('labels', 'visibility');
    if (visibility == 'visible'){
        for (var i = 0; i < toggleableLayerIds.length; i++){
         map.setLayoutProperty(toggleableLayerIds[i], 'visibility', 'none');
        }
    } else {
        for (var i = 0; i < toggleableLayerIds.length; i++){
         map.setLayoutProperty(toggleableLayerIds[i], 'visibility', 'visible');
        }
    }
};


// STEP 3. COLORS
// GET GEOM TYPE 
var geomType = "fill-color";
function setGeom(){
    current_style = map.getStyle();
    if (current_style.name == "data"){
        geomType = "line-color";}
    else { 
        geomType = "fill-color";}
};

colors.forEach(function(color) {
    var swatch = document.createElement('button');
    swatch.style.backgroundColor = color;
    swatch.addEventListener('click', function() {
        var layer = document.querySelector('input[name=layer]:checked');
        if(layer.value == "infra"){
            map.setPaintProperty(layer.value, "line-color", color)}
        else{ 
            map.setPaintProperty(layer.value, geomType, color)};
    });
    swatches.appendChild(swatch);
});



// STEP 4 MAKE DATASET/ZOOM BUTTONS
myDataSets.forEach(function(zoomlevel) {
    var setZoom = document.createElement('button');
    var text = document.createTextNode(zoomlevel[0]);
    setZoom.appendChild(text);
    setZoom.addEventListener('click', function() {
        map.jumpTo({
            zoom : zoomlevel[1],
            center: [4.887861,52.358550]
            })
    });
    opties.appendChild(setZoom);
});

// GET CURRENT ZOOM LEVEL
function getZoom() {
    map.on('zoom', function() {
        var curZoom = map.getZoom();
        current_zoom.innerHTML = curZoom;
    });
};


// STEP 5 GET OBJECT ID
function getID() {
    map.on('mousemove', function(e) {
            var features = map.queryRenderedFeatures(e.point);
            if (features.length > 0) {
                var idText = features[0].properties.original_id ;
                original_id.innerHTML = idText;
            }
        });
}

// SCROLLAMA
function init( ){
    // Scrolllama
    // instantiate the scrollama
    var scroller = scrollama();

    // setup the instance, pass callback functions
    scroller
      .setup({
        container: "#scroll",
        graphic: ".scroll__graphic",
        text: ".scroll__text",
        step: ".step", // required
        offset: 0.5, // optional, default = 0.5
        debug: false // optional, default = false
      })
      .onStepEnter(handleStepEnter)
      .onStepExit(handleStepExit);

    window.addEventListener('resize', scroller.resize)

    function handleStepEnter(callback){
        callback.element.classList.add('is-active');
        callback.element.classList.remove('is-disabled');

        if (callback.index == 2) {
            setGeom();
        } 
        else if (callback.index == 4){getID();}
        else if (callback.index == 3){getZoom();}

    }
    function handleStepExit(callback){
        callback.element.classList.remove('is-active');
        callback.element.classList.add('is-disabled');
    };
};



init();

// SEARCH BAR
var searchdata = {};

function enableTypeahead() {
    $('#ttinput .typeahead' ).typeahead({
        hint: false,
        highlight: true,
        minLength: 2
    },
    {
        name: 'PDOK',
        displayKey: 'value',
        display: 'value',
        limit: 5,
        source: searchdata.bloodhoundengine,
        templates:{
            empty: [
                '<div class="noitems">',
                'Niets gevonden',
                '</div>'
            ].join('\n')
        }
    });
};

var searchInputListeners = function(){
    $('#ttinput .typeahead').on('typeahead:select',function(ev, suggestion) {
        getCoordinates(suggestion);
    });
    $('#ttinput .typeahead').on('typeahead:autocomplete', function(ev, suggestion) {
        getCoordinates(suggestion);
    });
    $('#ttinput .typeahead').on('keyup', function(e) {
        // Enter
        if(e.which == 13) {
            getCoordinates(suggestion);
        }
    });
};

function enableBloodhound() {
    searchdata.bloodhoundengine = new Bloodhound({
        datumTokenizer: function(d){return Bloodhound.tokenizers.whitespace(d.value);},
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: 'http://geodata.nationaalgeoregister.nl/locatieserver/suggest?rows=10&fq=type:woonplaats&q=%QUERY',
            wildcard: '%QUERY',
            transform: function(response){
                return $.map(response.response.docs, function(item){
                    return {
                        value : item.weergavenaam,
                        id: item.id
                    };
                });
            }
        }
    });
    searchdata.bloodhoundengine.initialize();
    // $(searchdata).trigger('engine-initialized');
};

function initSearch() {
    enableBloodhound();
    enableTypeahead();
    searchInputListeners();
}

initSearch();

function getCoordinates(suggestion){
    var plaats = suggestion.id;
    var url = 'http://geodata.nationaalgeoregister.nl/locatieserver/lookup?wt=json&id='+plaats;
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var myArr = JSON.parse(this.responseText);
            recenterMap(myArr);
        }
    };
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
};


function recenterMap(plaats){
        var locatieString = plaats.response.docs[0].centroide_ll;
        var latlong = [];
        latlong.push(Number(locatieString.substring(6, 16)), Number(locatieString.substring(17, locatieString.length-1)));
        console.log(latlong);
        map.jumpTo({
            center: latlong,
            zoom: 15,
            speed: 1.2,
            minZoom: 12
        });
    };

