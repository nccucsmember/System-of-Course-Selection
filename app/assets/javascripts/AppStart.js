/**
 * Created by Justin on 2017/9/7.
 */
var TopOffset = 60;


$(document).ready(function() {

    $('.ui.sticky').sticky();

    $('.rightMenu').sticky({
            offset : TopOffset
    });

    $(".ui.dropdown").dropdown();

});
