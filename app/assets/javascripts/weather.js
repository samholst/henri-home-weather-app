$(document).ready(function() {
  $('#search-form').submit(function(e) {
    var zip = $('#zip').val();
    search(zip);
    e.preventDefault();
  });

  $('#update').click(function() {
    var zip = $('#current-zip').val();
    search(zip);
  });

  $(document).on('click', '.location', function() {
    var zip = $(this).text();
    search(zip);
  });

  $('#save').click(function() {
    var zip = $('#zip').val();
    var csrf_token = $('meta[name="csrf-token"]').attr('content');

    $.post( "/locations", { zip: zip, authenticity_token: csrf_token })
      .done(function(data) {
        $('#saved-zip-list ul').append(
          "<li class='location'>" + data.location.zip + "</li>"
        );
      })
      .fail(function(data) {
        console.error("Data Failed: ", data);
      });
   });

  $('#show-celcius').on('change', function(){
    var isCelcius = $(this).prop("checked");

    if ($('#current-zip').val() === "") { return }

    $('span').each(function() {
      if (isCelcius) {
        $(this).html(convertToCelcius($(this).html()));
      } else {
        $(this).html(convertToFahrenheit($(this).html()));
      }
    });
  })
});

function search(zip) {
  $.get( "/search", { zip: zip })
    .done(function(data) {
      $('#high span').text(checkDisplayFormat(data.forecast.high));
      $('#low span').text(checkDisplayFormat(data.forecast.low));
      $('#average span').text(checkDisplayFormat(data.forecast.average));
      $('#current-temp span').text(checkDisplayFormat(data.forecast.current_temp));
      $('#current-zip').val(data.forecast.zip);
    })
    .fail(function(data) {
      console.error("Data Failed: ", data);
    });
}

function checkDisplayFormat(value) {
  var isCelcius = $('#show-celcius').prop("checked");

  if (isCelcius) { return  Math.round(value * 10) / 10; }

  return convertToFahrenheit(value);
}

function convertToFahrenheit(value) {
  var temp = Number(value) * (9 / 5) + 32;
  return Math.round(temp * 10) / 10;
}

function convertToCelcius(value) {
  var temp = (Number(value) - 32) * (5 / 9);
  return Math.round(temp * 10) / 10;
}
