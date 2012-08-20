var $container = $('#mason');
$container.imagesLoaded(function(){
  $container.masonry({
    itemSelector : '.origin_card'
    // columnWidth : 374
  });
});

$('#mason').masonry({
  // set columnWidth a fraction of the container width
  columnWidth: function( containerWidth ) {
    return containerWidth / 2;
  }
});