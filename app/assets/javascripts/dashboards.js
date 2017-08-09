
function removeRecipe() {
  $('.close-button').click(function(){
    var index = $(this).data('index');
    $(".callout.alert-callout-subtle[data-index="+index+"]")
    .addClass('animated zoomOutLeft')
    .hide(1000);
  });
}

$(function(){
  removeRecipe();
});
