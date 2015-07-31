# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#new_narigraph").on("ajax:success", (e, data, status, xhr) ->
    $("#new_narigraph").append xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#new_narigraph").append "<p>ERROR</p>"

$ ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    alert "The article was deleted."
