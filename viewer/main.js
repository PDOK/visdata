
var bounds = [
  [2.59326, 50.72915], // Southwest coordinates
  [8.85636, 54.76957]  // Northeast coordinates
];

// MAP OPTIONS
var options = {
  container: 'map',
  hash: true,
  style: 'achtergrond.json',
  zoom: 6,
  pitch: 0,
  bearing: 0,
  center: [5.19,52.33],
  attributionControl: false
}

mapboxgl.accessToken =  "pk.eyJ1IjoibmllbmViIiwiYSI6IlR6NWEzdmMifQ.dRVGdAluvTb9EIXVBREbzw";

// INITIALIZE MAP
var map = new mapboxgl.Map(options);
map.addControl(new mapboxgl.NavigationControl(), 'top-left'); 
map.addControl(new mapboxgl.AttributionControl(), 'bottom-left');
