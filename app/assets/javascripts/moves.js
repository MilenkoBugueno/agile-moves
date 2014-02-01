$(function(){
  $('#counter_2').countdown({
    image: 'img/digits.png',
    startTime: '01:12:12:00'
  });

  $('#counter').countdown({
    image: 'img/digits.png',
    startTime: '25:00',
    timerEnd: function(){ alert('end!'); },
    format: 'mm:ss'
  });
});