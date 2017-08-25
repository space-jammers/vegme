function adminChange() {
  $('.feedback-admin').change(function(){
    console.log(this.form);
    this.form.submit(function(e){
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
