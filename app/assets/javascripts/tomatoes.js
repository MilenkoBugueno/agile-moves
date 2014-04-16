function start_me() {

    var x;
    var stime;
    var fnull;
    x = document.getElementById("btoStart").name;
    stime = document.getElementById("txtTimer").value;
    fnull = ((stime < 10) ? "0" : "");
    stime = fnull + stime + ":00";
    //stime = "00:05";   //Debug-Zeit
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

        var anfang;
        var azeit;
        anfang = new Date();
        var stunden  = ((anfang.getHours() < 10) ? "0" : "");
        var minuten  = ((anfang.getMinutes() < 10) ? "0" : "");
        azeit = stunden + anfang.getHours() + ":" + minuten + anfang.getMinutes();
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
