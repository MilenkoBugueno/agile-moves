# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
###
Set timer countdown in seconds with callback
###

###
Hide hours
###

###
Set timer countdown to specyfied date
###

###
Set theme and captions
###

###
Simple digital clock
###
getRelativeDate = (days, hours, minutes) ->
  date = new Date((new Date()).getTime() + 60000 * 60 * 24 * days) # milisec 
# minutes 
# hours 
# days
  date.setHours hours or 0
  date.setMinutes minutes or 0
  date.setSeconds 0
  date
$("#countdown-1").timeTo 100, ->
  alert "Countdown finished"
  return

$("#countdown-11").timeTo
  seconds: 100
  displayHours: false

date = getRelativeDate(20)
document.getElementById("date-str").innerHTML = date.toString()
$("#countdown-2").timeTo date
date = getRelativeDate(7, 9)
document.getElementById("date2-str").innerHTML = date.toString()
$("#countdown-3").timeTo
  timeTo: date
  displayDays: 2
  theme: "black"
  displayCaptions: true
  fontSize: 48
  captionSize: 14

$("#clock-1").timeTo()