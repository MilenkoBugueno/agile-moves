# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#move_publish_date').datepicker
    dateFormat: 'yy-mm-dd'
jQuery ->
  $('#move_start_date').datepicker
    dateFormat: 'yy-mm-dd'
jQuery ->
  $('#tomato_publish_date').datepicker
    dateFormat: 'yy-mm-dd'

jQuery ->
  $("#move_registration_id").parent().parent().hide()
  $("#toggle_nominate").click ->
    $("#move_registration_id").parent().parent().show()
    return
# Hiding team field. TODO: hide only if move_type.has_team
# jQuery ->
#  $('#move_user_ids_1').parent().parent().parent().hide()
#  move_types = $('#move_move_type_id').html()
#  console.log(move_types)
#  move_types.hide()
