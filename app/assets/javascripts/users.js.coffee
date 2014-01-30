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

######### DELETE PROJECT#######
  $('#projects-revealed-here').on "click","a[id='delete_project']", (e) ->
    e.preventDefault
    id = $(this).attr('data-id')
    params = {id: id}
    if confirm('This action is irreversible. Are you sure you want to delete this project?')
      $.ajax(
        url: '/projects/' + id
        type: 'DELETE'
        data: params
        dataType: 'json').done (data) ->
          project_box = "#" + data.project
          $(project_box).remove()
