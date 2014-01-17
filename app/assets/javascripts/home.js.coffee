# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).foundation();

# loadMapboxScript = ->
#   script = document.createElement("script")
#   script.src = "//api.tiles.mapbox.com/mapbox.js/v1.5.2/mapbox.js"
#   script.type = "text/javascript"
#   head = document.getElementsByTagName("head")[0]
#   cssScript = $("#mapbox-stylesheet")
#   head.insertBefore script, cssScript


########### LOAD MAPS ###########
$(document).ready ->

  if $("#home-map").length > 0
    map = L.mapbox.map("home-map", null,
      shareControl: true
    ).setView([24.13, -44.56], 3).addControl(L.mapbox.geocoderControl(gon.map_id))

  #Customize layers
    watercolor_layer = new L.StamenTileLayer("watercolor")
    name_layer = L.tileLayer("https://{s}.tiles.mapbox.com/v3/" + gon.map_id + "/{z}/{x}/{y}.png",
      attribution: "<a href=\"http://www.mapbox.com/about/maps/\" target=\"_blank\">Terms &amp; Feedback</a>"
    )

    map.addLayer watercolor_layer
    map.addLayer name_layer



  #Markers
    geojson =
      features: [
        geometry:
          coordinates: [-122.2256401, 37.7698573]
          type: "Point"

        properties:
          description: "<p>SoundFrame is an app that allows you to tells stories through sounds and maps. Journalists, travelers and storyteller will get a kick out of it.</p> <a id=\"next\" href=\"#\">Next</a>"
          id: "marker-hp3iwdvc"
          "marker-color": "#D25E15"
          "marker-size": "medium"
          "marker-symbol": ""
          title: "<h1>Welcome to SoundFrame</h1>"

        type: "Feature"
      ,
        geometry:
          coordinates: [2.35337831438349, 48.8374883252818]
          type: "Point"

        properties:
          description: "...Add sounds, photos and text to a map. Like <a id=\"home-example-link\" href=\"#\">This!</a><br/><a id=\"next\" href=\"#\">Next</a>"
          id: "marker-hp3izy7a"
          "marker-color": "#D25E15"
          "marker-size": "medium"
          "marker-symbol": ""
          title: "<h1>Create maps</h1>"

        type: "Feature"
      ,
        geometry:
          coordinates: [121.352146168479, 31.0917975938839]
          type: "Point"

        properties:
          description: "Share you maps with friends! <br/> <a class=\"left-off-canvas-toggle\" href=\"#\">Start now!</a> "
          id: "marker-hp3j2iya"
          "marker-color": "#D25E15"
          "marker-size": "medium"
          "marker-symbol": ""
          title: "<h1>Share with the world</h1>"

        type: "Feature"
      ]
      id: "laurenbenichou.gh8c0187"
      type: "FeatureCollection"

    markers = L.mapbox.markerLayer(geojson).addTo(map)
    chapters = []
    markers.eachLayer (chapter) ->
      chapters.push chapter
      chapters


  # First popup open on load
    chapters[0].openPopup()
    a = chapters[0].feature.geometry.coordinates
    map.setView [a[1], a[0]], 3

  #Click action to move from one marker to the next
    i = -1
    $("#home-map").on "click", "a[id='next']", (e) ->
      e.preventDefault()
      i = (i + 1) % chapters.length
      c = chapters[i].feature.geometry.coordinates
      map.setView [c[1], c[0]], 3
      chapters[i].openPopup()

    $("#home-map").on "click", "a[id='home-example-link']", (e) ->
      e.preventDefault()
      $("#information").toggle "slow"

    $("#information").on "click", "i[id='close-information']", ->
      $("#information").toggle "slow"
