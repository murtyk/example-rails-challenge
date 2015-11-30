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

// for search page

// for autocomplete
$(function() {
  return $('#charge_client_name').autocomplete({
    source: $('#charge_client_name').data('autocomplete-source')
  });
});

// fetch charges json and build the tables
$(document).ready(function() {
  $('#button_search_charges').click(function(e) {
    var client_name = $('#charge_client_name').val();

    if (client_name.length == 0){
      return false;
    }

    var ar = client_name.split("---");
    var client_data = ar[1].split(':');
    var client_type = client_data[0];
    var client_id   = client_data[1];

    url = '/charges/search?client_type=' + client_type + '&client_id=' + client_id;

    $.get(url, function(data) {
      build_charge_tables(data);
    }, "json");

    e.preventDefault();
  });
});

function build_charge_tables(data) {
  var failed_charges = data['failed_charges'];
  var disputed_charges = data['disputed_charges'];
  var successful_charges = data['successful_charges'];

  var tr;

  $('#table-failed-charges').html('');
  $('#table-disputed-charges').html('');
  $('#table-successful-charges').html('');

  $.each(failed_charges, function(index, row){
    tr = build_tr(row, 'failed-row');
    $('#table-failed-charges').append(tr);
  });

  $.each(disputed_charges, function(index, row){
    tr = build_tr(row, 'disputed-row');
    $('#table-disputed-charges').append(tr);
  });

  $.each(successful_charges, function(index, row){
    tr = build_tr(row, 'successful-row');
    $('#table-successful-charges').append(tr);
  });
}

function build_tr(row, row_class){
  tr = "<tr class='" + row_class + "'>";
  tr += build_td(row.date);
  tr += build_td(row.amount);
  tr += "</tr>";

  return tr;
}

function build_td(d){
  return ("<td>" + d + "</td>");
}
