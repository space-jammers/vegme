
function removeRecipe() {
  $('.close-button').click(function(){
    var index = $(this).data('index');
    $(".callout.alert-callout-subtle[data-index="+index+"]")
    .addClass('animated zoomOutLeft')
    .hide(1000);
  });
}

function mobileTabs(){
  if ($(window).width() <= 730) {
    $("#example-tabs").addClass("vertical");
  }else {
      $("#example-tabs").removeClass("vertical");
  }
}

$(function(){
  removeRecipe();
  mobileTabs();
});
