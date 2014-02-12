
/**
 * Hide hours
 */
$('#countdown').timeTo({
    seconds: 100,
    displayHours: false
});

var date = getRelativeDate(20);

document.getElementById('date-str').innerHTML = date.toString();

