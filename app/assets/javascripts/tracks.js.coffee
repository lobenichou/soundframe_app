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
  SC.get "/users/" + id + "/tracks",
    limit: 20
    , (tracks) ->
      track_list = JST["templates/tracks"]({tracks: tracks})
      $("#tracks").append(track_list)

