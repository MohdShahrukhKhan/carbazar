//= require active_admin/base

$(document).ready(function() {
    // Hide launch_date field if car type is 'New Car'
    function toggleLaunchDateField() {
      var carType = $('#car_types_select').val();
      if (carType === 'New Car') {
        $('.launch-date-field').parent().hide(); // Hide the field
      } else {
        $('.launch-date-field').parent().show(); // Show the field
      }
    }
  
    // Initial call to hide/show field based on preselected value
    toggleLaunchDateField();
  
    // Bind change event to car type dropdown
    $('#car_types_select').change(function() {
      toggleLaunchDateField();
    });
  });


  