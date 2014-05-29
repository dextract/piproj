$(function(){
    $(".multiselect").multiSelect();
});

$(function(){
    $(".button").click(function() {
        var vid = $(".ms-elem-selection.ms-selected").children('span').append('\n').text();
        $.ajax({
            url: '/contents/setPlaylist',
            method: 'post',
            data: {
                vidurl: vid
            }
        });
    });
});