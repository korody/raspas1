jQuery(document).ready(function($) {
    jQuery('a.popup').on('click', function(){
        newwindow=window.open($(this).attr('href'),'','height=260,width=660');
        if (window.focus) {newwindow.focus()}
        return false;
    });
});