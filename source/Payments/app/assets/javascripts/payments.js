// for new page
$(document).ready(function() {
  $('#charge_user_id').change(function(e) {
    var text = $('#charge_user_id option:selected').text();
    if (text.length > 0){
      $('#charge_company_id').val('');
    }
  });

  $('#charge_company_id').change(function(e) {
    var text = $('#charge_company_id option:selected').text();
    if (text.length > 0){
      $('#charge_user_id').val('');
    }
  });
});
