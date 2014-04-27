function start_me(userid, username, title, tomato_id) {

    var anfang;
    var ende;
    var azeit;
    anfang = new Date();
    var stunden  = ((anfang.getHours() < 10) ? "0" : "");
    var minuten  = ((anfang.getMinutes() < 10) ? "0" : "");
    var estunden;
    var eminuten;
    var x;
    var stime;
    var fnull;
    var ezeit;
    var tomatendauer;

    x = document.getElementById("btoStart").name;
    tomatendauer = document.getElementById("txtTimer").value;
    ende = new Date(anfang.getTime() + 60000*tomatendauer);
    estunden  = ((ende.getHours() < 10) ? "0" : "");
    eminuten  = ((ende.getMinutes() < 10) ? "0" : "");

    fnull = ((stime < 10) ? "0" : "");
    stime = fnull + tomatendauer + ":00";
    //stime = "00:05";   //Debug-Zeit
    azeit = stunden + anfang.getHours() + ":" + minuten + anfang.getMinutes();
    ezeit = estunden + ende.getHours() + ":" + eminuten + ende.getMinutes();
    window.open('/de/live_tomatoes/new?live=1&tomato_id=' + tomato_id + '&userid=' + userid + '&username=' + username + '&title=' + title + '&starttime=' + azeit + '&endtime=' + ezeit + '&currenttime=' + tomatendauer,'mywindow');

    if (x == "los")
    {

        document.getElementById("counter_2").innerHTML = ""; //entfernt die Timer-Grafik aus dem div
        $(function(){
            $('#counter_2').countdown({
            image: '/assets/digits.png',
            startTime: stime,
            timerEnd: function(){ end_me(); },
            format: 'mm:ss'
            });
        });

        document.getElementById("btoStart").name = "laeuft";


        document.getElementById("tomato_start_time").value = azeit;
        document.getElementById("tomato_end_time").value = "";
        document.getElementById("btoStart").disabled = true;
    }
}

function end_me() {

    var ende;
    var ezeit;
    ende = new Date();
    var stunden  = ((ende.getHours() < 10) ? "0" : "");
    var minuten  = ((ende.getMinutes() < 10) ? "0" : "");
    ezeit = stunden + ende.getHours() + ":" + minuten + ende.getMinutes();
    document.getElementById("tomato_end_time").value = ezeit;

    //var zeita = document.getElementById("start_time").value;
    //var zeite = document.getElementById("end_time").value;

    document.getElementById("btoStart").name = "los";
    document.getElementById("btoStart").disabled = false;

    alert("AUFHÖREN!");

}

function rate_me(x) {
    document.getElementById("rating_star_rating").value = x;
}