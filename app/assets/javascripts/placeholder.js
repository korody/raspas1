$(function() { 
    $('input[type="text"]').each(function () { 
        $(this).focus(function () { 
            if ($(this).attr('value') === $(this).attr('placeholder')) { 
                $(this).css('',''); 
                $(this).attr('value', ''); 
            } 
        }).blur(function () { 
            if ($(this).attr('value') === '') { 
                $(this).css('',''); 
                $(this).attr('value', $(this).attr('placeholder')); 
            } 
        }).blur(); 
    }); 
});

$(function() { 
    $('textarea').each(function () { 
        $(this).focus(function () { 
            if ($(this).attr('value') === $(this).attr('placeholder')) { 
                $(this).css('',''); 
                $(this).attr('value', ''); 
            } 
        }).blur(function () { 
            if ($(this).attr('value') === '') { 
                $(this).css('',''); 
                $(this).attr('value', $(this).attr('placeholder')); 
            } 
        }).blur(); 
    }); 
}); 

