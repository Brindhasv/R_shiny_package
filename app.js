$(document).ready(function() {
    $('#file').change(function() {
      var filename = $(this).val().split('\\').pop();
      $('#data_table').text('Uploading ' + filename + '...');
      var data = new FormData();
      data.append('file', $(this)[0].files[0]);
      $.ajax({
        type: 'POST',
        url: 'upload',
        data: data,
        contentType: false,
        processData: false,
        success: function(response) {
          $('#data_table').html(response.data_table);
          $('#bar_plot').html(response.bar_plot);
        },
        error: function() {
          $('#data_table').text('Error uploading file.');
        }
      });
    });
  });
  