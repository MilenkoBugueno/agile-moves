var tt_tomaten_zeit;

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
    var titletimer;

    x = document.getElementById("btoStart").name;
    tomatendauer = document.getElementById("txtTimer").value;

    ende = new Date(anfang.getTime() + 60000*tomatendauer);
    estunden  = ((ende.getHours() < 10) ? "0" : "");
    eminuten  = ((ende.getMinutes() < 10) ? "0" : "");

    fnull = ((tomatendauer < 10) ? "0" : "");
    stime = fnull + tomatendauer + ":00";
    //stime = "00:05";   //Debug-Zeit
    tt_tomaten_zeit = stime;
    azeit = stunden + anfang.getHours() + ":" + minuten + anfang.getMinutes();
    ezeit = estunden + ende.getHours() + ":" + eminuten + ende.getMinutes();
    window.open('/de/live_tomatoes/new?live=1&tomato_id=' + tomato_id + '&userid=' + userid + '&username=' + username + '&title=' + title + '&starttime=' + azeit + '&endtime=' + ezeit + '&currenttime=' + tomatendauer,'mywindow');

    if (x == "los")
    {

        document.getElementById("counter_2").innerHTML = ""; //entfernt die Timer-Grafik aus dem div
        titletimer = setInterval("update_title()", 1000);
        $(function(){
            $('#counter_2').countdown({
            image: '/assets/digits.png',
            startTime: stime,
            timerEnd: function(){ end_me(titletimer); },
            format: 'mm:ss'
            });
        });

        document.getElementById("btoStart").name = "laeuft";


        document.getElementById("tomato_start_time").value = azeit;
        document.getElementById("tomato_end_time").value = "";
        document.getElementById("btoStart").disabled = true;
    }
}

function end_me(titletimer) {

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
    window.clearInterval(titletimer);
    document.getElementById("tomato_finished_id").play();
    alert("AUFHÖREN!");

}

function update_title() {
    var zeit = tt_tomaten_zeit.split(":");
    var tmp;
    var anzeigezeit;

    if (tt_tomaten_zeit != "0:00") {
        switch (Number(zeit[1])) {
            case 0:
                zeit[1] = "59";
                if (Number(zeit[1]) > 0) {
                    tmp = Number(zeit[0]) - 1;
                    zeit[0] = tmp.toString();
                }
                break;
            case 1:
                zeit[1] = "00";
                break;
            default:
                tmp = Number(zeit[1]) - 1;
                zeit[1] = tmp.toString();
        }
    }
    var sekunden  = ((zeit[1].length == 1) ? "0" : "");
    var minuten  = ((zeit[0].length == 1) ? "0" : "");
    tt_tomaten_zeit = zeit[0] + ":" + zeit[1];
    anzeigezeit = minuten + zeit[0] + ":" + sekunden + zeit[1];
    window.document.title = anzeigezeit;
}

function rate_me(x) {
    document.getElementById("rating_star_rating").value = x;
}

function show_comment() {

    if (document.getElementById("tom_change_inp").style.display == "block") {
        document.getElementById("tom_change_inp").style.display = "none";
        document.getElementById("rating_body").value = "";
    }
    else {
        document.getElementById("tom_change_inp").style.display = "block"
    }
    //Verhindert ein Ausführen des Links
    return false;
}

function thumb_it(x) {
    document.getElementById("rating_thumb_rating").value = x;
    if (x == 1) {
        document.getElementById("tomato_goal_up").style.height = "30px";
        document.getElementById("tomato_goal_down").style.height = "20px";
        document.getElementById("tomato_goal_up").onmouseout = function()
        {
          //don't change the function
        };
        document.getElementById("tomato_goal_down").onmouseout = function()
        {
            this.style='height: 20px';
        };
    }
    else {
        document.getElementById("tomato_goal_down").style.height = "30px";
        document.getElementById("tomato_goal_up").style.height = "20px";
        document.getElementById("tomato_goal_down").onmouseout = function()
        {
           //don't change the function
        };
        document.getElementById("tomato_goal_up").onmouseout = function()
        {
            this.style='height: 20px';
        };
    }

    return false;
}