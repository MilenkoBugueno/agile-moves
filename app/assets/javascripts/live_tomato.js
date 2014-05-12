/**
 * Created by Torsten on 18.04.2014.
 */

/* jQuery Calls */

$(document).ready(function(){
    $("#new_live_tomato").submit();

    if ($('#live_tomato_table')) {
        setInterval(update_table, 20000);
    }
});

//Ajax Call für löschen einer Live Tomato
$(document).on('ajax:success', '.remove_live_tomato', function(e) {
    $(e.currentTarget).closest('tr').fadeOut();
});

function update_table() {

    var x;
    var rows;

    //löst einen Refresh des Ankers aus
    $('#live_ajax').find('.refresh_live_list').trigger('click');

    x = document.getElementById('live_tomato_table');
    rows = x.rows.length;

    $('#live_tomato_table tr').each(function () {
        $(this).find('.remaining').each(function () {

            var remain = $(this).html();
            if (remain > 0) {
                remain = remain - 1;
                $(this).html(remain);
            }

        })


    })



}