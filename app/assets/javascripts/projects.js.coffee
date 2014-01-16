# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).foundation();

########### LOAD MAPS ###########

if $("#map-project").length > 0
  map_project = L.mapbox.map("map-project", null,
    shareControl: true
  ).setView([24.13, -44.56], 3).addControl(L.mapbox.geocoderControl(gon.map_id))

## load layers ##

  watercolor_layer =  new L.StamenTileLayer("watercolor")
  name_layer = L.tileLayer("https://{s}.tiles.mapbox.com/v3/" + gon.map_id + "/{z}/{x}/{y}.png",
    attribution: "<a href=\"http://www.mapbox.com/about/maps/\" target=\"_blank\">Terms &amp; Feedback</a>"
  )

  map_project.addLayer watercolor_layer
  map_project.addLayer name_layer

## place markers on map ##

for index of gon.coordinates
  popupContent = "<a href='#' class='target-info'>" + gon.track_title[index] + "</a>"
  L.marker(gon.coordinates[index],
  icon: L.mapbox.marker.icon("marker-color": "CC0033")
  ).addTo(map_project).bindPopup(popupContent)

# placeMarker = (map_project, latlng) ->
#   popupContent = "<a href='#' class='target-library'>" + "Add track" + "</a>"
#   LatLng = new L.LatLng(latlng.lat, latlng.lng)
#   marker = new L.Marker(LatLng,
#     icon: L.mapbox.marker.icon("marker-color": "CC0033")
#     draggable: true
#   )
#   marker.bindPopup(popupContent)
#   marker.addTo map_project

# map_project.on "click", (e) ->
#   placeMarker map_project, e.latlng

######## ON CLICK EVENTS ##########
$(document).ready ->
  $("#map-project").on "click", "a[class='target-info']", (e) ->
    e.preventDefault
    unless $("#information").is(":visible")
      $("#information").slideToggle "slow"

  $("#close-info").on "click", ->
    $("#information").slideToggle "slow"


####### SAVING TRACK LOCATIONS ##########


  $("#all-tracks").on "click", "a[data-id]", (e) ->
    e.preventDefault()
    proj_id = window.location.href.match(/projects\/\d*\//)[0].split("/")[1]
    id = $(this).attr("data-id")
    location = $("#location_#{id}").val()
    params = {track: id, location: location, project: proj_id}
    $.ajax(
      url: '/projects/' + proj_id
      type: 'PUT'
      data: params
      dataType: 'json').done (data) ->
        hidden_div = "#" + "fade_" + data.track
        visible_div = "#" + data.track
        $(visible_div).toggleClass("fade").empty()
        $(visible_div).append("<i class='fi-check large'></i>The track was added to your map!")



######### MASONRY #############
if $("#all-tracks").length > 0
  container = document.querySelector("#container")
  msnry = new Masonry(container,

    # options
    columnWidth:100
    itemSelector: ".box"
    isAnimated: !Modernizr.csstransitions,
    isFitWidth: true
  )





