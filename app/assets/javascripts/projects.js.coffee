# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).foundation();


########### LOAD MAPS ###########

$(document).ready ->
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
      console.log gon.soundcloud_track_id[index]
      popupContent = "<a href='#' class='target-info' data-id='#{gon.soundcloud_track_id[index]}'>" + gon.track_title[index] + "</a>"
      L.marker(gon.coordinates[index],
      icon: L.mapbox.marker.icon("marker-color": "#D25E15")
      ).addTo(map_project).bindPopup(popupContent)


######## ON CLICK EVENTS ########

    $("#map-project").on "click", "a[class='target-info']", (e) ->
      e.preventDefault
      unless $("#information").is(":visible")
        id = $(this).attr("data-id")
        $("#information").slideToggle "slow"
        single_track = JST["templates/single_track"]({id: id})
        $("#information").append(single_track)

    $("#information").on "click", "i[id='close-information']", ->
      $("#information").contents(':not(#close-information)').remove()
      $("#information").toggle "slow"


####### SAVING TRACK LOCATIONS #######

  $("#all-tracks").on "click", "a[data-id]", (e) ->
    e.preventDefault()
    id = $(this).attr("data-id")
    location = $("#location_#{id}").val()
    params = {track: id, location: location, project: gon.project_id}
    $.ajax(
      url: '/projects/' + gon.project_id
      type: 'PUT'
      data: params
      dataType: 'json').done (data) ->
        hidden_div = "#" + "fade_" + data.track
        visible_div = "#" + data.track
        $(visible_div).toggleClass("fade").empty()
        $(visible_div).append("<i class='fi-check large'></i>The track was added to your map!")

  $("#setMap").on "click", "input[name='answer']", ->
    form = $(this).closest('div#setMap').find('#map_region')
    if $(this).is(':checked') && $(this).val() == "Yes" && form.is(':visible') == false
      $("#map_region").toggle "slow"
    else if $(this).is(':checked') && $(this).val() == "No"  &&  form.is(':visible')
      $("#map_region").toggle "slow"

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





