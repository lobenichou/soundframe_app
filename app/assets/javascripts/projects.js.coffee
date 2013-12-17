# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#initialize map#
map_project = L.mapbox.map("map-project", null, {
      shareControl: true
  })

map_project.setView [24.13, -44.56], 3
map_project.addControl(L.mapbox.geocoderControl(gon.map_id))

#layers#

watercolor_layer = new L.StamenTileLayer("watercolor")
name_layer = L.tileLayer('https://{s}.tiles.mapbox.com/v3/'+ gon.map_id + '/{z}/{x}/{y}.png', {
      attribution: '<a href="http://www.mapbox.com/about/maps/" target="_blank">Terms &amp; Feedback</a>'
  })

map_project.addLayer(watercolor_layer)
map_project.addLayer(name_layer)

#place markers on map#

placeMarker = (map_project, latlng) ->
  popupContent = "<a href='#' class='target-library'>" + "Add track" + "</a>"
  LatLng = new L.LatLng(latlng.lat, latlng.lng)
  marker = new L.Marker(LatLng,
    icon: L.mapbox.marker.icon("marker-color": "CC0033")
    draggable: true
  )
  marker.bindPopup(popupContent)
  marker.addTo map_project

map_project.on "click", (e) ->
  placeMarker map_project, e.latlng

#On click events#
$("#map-project").on "click", "a[class='target-library']", (e) ->
  e.preventDefault
  unless $("#info").is(":visible")
    $("#info").slideToggle "slow"

$("tr").draggable()



