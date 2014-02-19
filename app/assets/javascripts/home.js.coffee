# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).foundation();

########### LOAD MAP ###########
$(document).ready ->
  $("#target-side-bar").mouseover ->
    $(".left-off-canvas-toggle").click()


  if $("#home-map").length > 0
    map = L.mapbox.map("home-map", null,
      shareControl: true
    ).setView([24.13, -44.56], 3).addControl(L.mapbox.geocoderControl(gon.map_id))

##Customize layers##

    watercolor_layer = new L.StamenTileLayer("watercolor")
    name_layer = L.tileLayer("https://{s}.tiles.mapbox.com/v3/" + gon.map_id + "/{z}/{x}/{y}.png",
      attribution: "<a href=\"http://www.mapbox.com/about/maps/\" target=\"_blank\">Terms &amp; Feedback</a>"
    )

    map.addLayer watercolor_layer
    map.addLayer name_layer

##Markers##
    geojson =
      features: [
        geometry:
          coordinates: [-122.2256401, 37.7698573]
          type: "Point"

        properties:
          description: "<strong>NOTE: This app performs much better on a desktop. Mobile optimization is coming soon...</strong><br/><br/>SoundFrame is an app that allows you to tell stories through sounds and maps. Journalists, travelers and storyteller will get a kick out of it. <a id=\"next\" href=\"#\">Next</a>"
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


##First popup open on load##

    chapters[0].openPopup()
    a = chapters[0].feature.geometry.coordinates
    map.setView [a[1], a[0]], 3

##Click action to move from one marker to the next##

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

    $("#information").on "click", "i[id='close-information-home']", (e) ->
      $("#information").toggle "slow"
