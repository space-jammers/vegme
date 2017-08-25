function adminChange() {
  $('.feedback-admin-form').click(function(){
    this.submit(function(e){
      e.preventDefault();
    });
  });
}

function completeChange() {
  $('.feedback-complete-form').click(function(){
    this.submit(function(e){
      e.preventDefault();
    });
  });
}

$(function(){
  adminChange();
  completeChange();
});
