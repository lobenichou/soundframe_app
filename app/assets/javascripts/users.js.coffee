# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).foundation()

####### REVEAL PROJECTS ########

$(document).ready ->
  $("#user-info").on "click", "a[id='reveal-project']", (e) ->
    e.preventDefault
    $("#user-info").toggle "slow"
    $("#all-projects").toggle "slow"

  $("#close-project").on "click", ->
    $("#all-projects").toggle "slow"
    $("#user-info").toggle "slow"


######### MASONRY #############

  if $("#all-container").length > 0
    container = document.querySelector("#container")
    msnry = new Masonry(container,

      # options
      columnWidth:100
      itemSelector: ".box"
      isAnimated: !Modernizr.csstransitions,
      isFitWidth: true
    )
