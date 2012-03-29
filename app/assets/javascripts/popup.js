jQuery(document).ready(function($) {
    jQuery('a.popup').live('click', function(){
        newwindow=window.open($(this).attr('href'),'','height=260,width=660');
        if (window.focus) {newwindow.focus()}
        return false;
    });
});