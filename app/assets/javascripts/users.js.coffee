# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

######### MASONRY #############

container = document.querySelector("#container")
msnry = new Masonry(container,

  # options
  columnWidth:100
  itemSelector: ".box"
  isAnimated: !Modernizr.csstransitions,
  isFitWidth: true
)

