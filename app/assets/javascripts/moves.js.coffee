jQuery ->
  $("#counter_2").countdown
    image: "img/digits.png"
    startTime: "01:12:12:00"

  $("#counter").countdown
    image: "img/digits.png"
    startTime: "25:00"
    timerEnd: ->
      alert "end!"
      return

    format: "mm:ss"

  return
