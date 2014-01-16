# Saving tracks to the current user's library#

$("#submit_query").on "click", (event) ->
  event.preventDefault()
  $("#search_results").empty()
  query = $("#search_query").val()

  if query == ""
    alert "you must enter a soundcloud username!"
  else
    SC.get "/users",
    q: query
    limit: 20
    , (users) ->
      list = JST["templates/users"]({users: users})
      $("#search_results").append(list)

$("#search_results").on "click", "div", ->
  $("#tracks").empty()
  id = $(this).attr("id")
  SC.get "/users/#{id}/tracks",
    limit: 20
    , (tracks) ->
      track_list = JST["templates/tracks"]({tracks: tracks})
      $("#tracks").append(track_list)

$("#tracks").on "click", "a[class='save_track']", (event) ->
  event.preventDefault
  id = $(this).attr("data-id")
  SC.get "/tracks/" + id
    , (track) ->
      params = {track: track, user_id: gon.current_user.id}
      $.post("/tracks", params).done (data) ->
        id = data.track.id
        text = data.text
        $("a[data-id='#{id}']").html("#{data.text}")
        $("a[data-id='#{id}']").toggleClass("active")

