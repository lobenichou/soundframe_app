# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).foundation();

$(document).ready ->

########### LOAD MAPS ###########

## Sets map on a specific region if user chooses to do so##

  if $("#map-project").length > 0

    if gon.project_region != null

      showMap = (err, data) ->
        map_project.fitBounds(data.lbounds)

      geocoder = L.mapbox.geocoder(gon.map_id)

      map_project = L.mapbox.map("map-project", null,
        shareControl: true
      ).addControl(L.mapbox.geocoderControl(gon.map_id))

      geocoder.query(gon.project_region, showMap)

    else if gon.project_region == null

      map_project = L.mapbox.map("map-project", null,
      shareControl: true
      ).setView([24.13, -44.56], 3).addControl(L.mapbox.geocoderControl(gon.map_id))

## load layers ##
    watercolor_layer =  new L.StamenTileLayer("watercolor")
    name_layer = L.tileLayer("https://{s}.tiles.mapbox.com/v3/" + gon.map_id + "/{z}/{x}/{y}.png", attribution: "<a href=\"http://www.mapbox.com/about/maps/\" target=\"_blank\">Terms &amp; Feedback</a>")
    map_project.addLayer watercolor_layer
    map_project.addLayer name_layer

## place markers on map ##
    for index of gon.coordinates
      popupContent = "<img src=" + '"' + gon.user_image_thumb[index] + '"' + "/>" + "<br/>" + "<a href='#' class='target-info' data-id='#{gon.soundcloud_track_id[index]}'>" + gon.track_title[index] + "</a>"
      markers = L.marker(gon.coordinates[index],
      icon: L.mapbox.marker.icon("marker-color": "#D25E15")
      ).addTo(map_project).bindPopup(popupContent)

######## MAP: ON CLICK EVENTS ########

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

  $("#show-track-list").on "click", ->
    $("#map-track-list").fadeToggle "slow"

  $("#map-track-list").on "click", "div[class='find_track']", ->
    id = $(this).attr("data-id")
    map_project.setView(gon.coordinates[id], 7)


######## EDIT MAP: ON CLICK EVENTS #########

  $("#setMap").on "click", "input[name='answer']", ->
    form = $(this).closest('div#setMap').find('#map_region')
    if $(this).is(':checked') && $(this).val() == "Yes" && form.is(':visible') == false
      $("#map_region").toggle "slow"
    else if $(this).is(':checked') && $(this).val() == "No"  &&  form.is(':visible')
      $("#map_region").toggle "slow"



####### SAVING TRACK LOCATIONS + REGION #######

  $("#all-tracks").on "click", "a[id='add_location']", (e) ->
    e.preventDefault()
    id = $(this).attr("data-id")
    location = $("#location_#{id}").val()
    if location == ""
      alert "The location can't be empty"
     else
      params = {track: id, location: location, project: gon.project_id}
      $.ajax(
        url: '/projects/' + gon.project_id + '/update_track_location'
        type: 'GET'
        data: params
        dataType: 'json').success (data) ->

          visible_div = "#" + data.track
          $(visible_div).toggleClass("fade").empty()
          $(visible_div).append("<i class='fi-check large'></i>The track was added to your map! <br/> ")

        .error (data) ->
          alert "An error occured. Please try again"


  $("#setMap").on "click", "a[id='submit_answer']", ->
    form = $(this).closest('div#setMap').find('#map_region')
    yes_answer = $(this).closest('div#setMap').find('#positive_answer')
    region = form.val()
    if yes_answer.is(':checked') && region != ""
      params = {project: gon.project_id, region: region}
      $.ajax(
        url: '/projects/' + gon.project_id + '/update_map_region'
        type: 'PUT'
        data: params).success (data) ->
         alert "region saved"
        .error (data) ->
          error = "<p>An error occured. Please try again</p>"
          $("#setMap").append(error)



#########SAVING IMAGE FOR TRACK##########

  $("#all-tracks").on "click", "a[class='addImageTrigger']", ->
    id = $(this).attr("data-id")
    form = JST["templates/add_image_form"](id: id)
    $("#addImage").empty()
    $("#addImage").append(form)

  $("#addImage").on "click", "a[id='upload_image']", (event) ->
      event.preventDefault()
      formData = new FormData()
      track_id = $(this).attr("data-id")
      input = $(this).closest('div#addImage').find('#image')
      formData.append('project[image]', input[0].files[0]);
      formData.append('track_id', track_id)
      $.ajax(
        url: '/projects/' + gon.project_id + '/add_image_to_track'
        data: formData
        cache: false
        contentType: false
        processData: false
        type: 'PUT'
        ).success (data) ->
          alert data.text
          $(".close-reveal-modal").click()
          div_to_change = "#" + "add_image_" + data.track
          $(div_to_change).html("<i class='fi-check large'></i>Image Added")
        .error (data) ->
          alert "An error occured. Please try again."
          $(".close-reveal-modal").click()


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


