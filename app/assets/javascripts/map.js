var loc = new google.maps.LatLng(gon.lat, gon.lon);
var marker;
var map;

function initialize() {
  var mapOptions = {
    zoom: 16,
    center: loc
  };

  map = new google.maps.Map(document.getElementById('map-canvas'),
          mapOptions);

  marker = new google.maps.Marker({
    map:map,
    title:"<%= @home.address %>",
    draggable:false,
    animation: google.maps.Animation.DROP,
    position: loc
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
google.maps.event.addDomListener(window, 'resize', initialize);