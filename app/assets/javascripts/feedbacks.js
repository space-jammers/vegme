function adminChange() {
  $('.feedback-admin-form').click(function(){
    this.submit(function(e){
      e.preventDefault();
    });
  });
}

$(function(){
  adminChange();
});
