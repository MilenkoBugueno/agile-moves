// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require ckeditor/init
//= require twitter/bootstrap
//= require bootstrap
//= require_tree .
//= require_tree ./ckeditor

function select_all_team(name, text_all, text_none) {
    var all = document.getElementsByName(name).length - 1;
    var obj = document.getElementsByName(name);
    var sel = 0;

    for (var i = 0; i < obj.length - 1; i++ )
    {
        if (obj[i].checked == true) {
            sel++;
        }
    }

    if (sel == all) {
       //Alle Angehakt
        document.getElementById("link_all_team").innerHTML = text_all;
        for (var i = 0; i < obj.length - 1; i++ )
        {
            obj[i].checked = false;
        }
    }
    else {
        //Nicht alle angehakt
        document.getElementById("link_all_team").innerHTML = text_none;
        for (var i = 0; i < obj.length - 1; i++ )
        {
            obj[i].checked = true;
        }
    }

}

$(document).ready(function(){
    $("select").change(function(){
        $( "select option:selected").each(function(){
            if($(this).attr("value")=="1"){
                $(".move_users").show();
            }
            if($(this).attr("value")=="2"){
                $(".move_users").hide();

            }
        });
    }).change();
});