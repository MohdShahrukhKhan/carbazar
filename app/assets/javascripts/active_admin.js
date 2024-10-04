//= require active_admin/base

$(document).ready(function() {
  
    function toggleLaunchDateField() {
      var carType = $('#car_types_select').val();
      console.log("Car Type Selected: ", carType); // Debugging line to check carType value
      if (carType === 'New Car') {
        $('.launch-date-field').hide();  // Hiding the field itself
      } else {
        $('.launch-date-field').show();  // Showing the field itself
      }
    }
  
    // Call function on document ready
    toggleLaunchDateField();
  
    // Change event for dropdown
    $('#car_types_select').change(function() {
      toggleLaunchDateField();
    });
});

document.addEventListener('DOMContentLoaded', function() {
  // Toggle fields based on plan type
  var planTypeField = document.getElementById('plan_plan_type');

  if (planTypeField) {
    planTypeField.addEventListener('change', toggleFields);
    toggleFields(); // Initialize visibility based on the current selection
  }

  function toggleFields() {
    var planType = planTypeField.value;

    // If the plan type is free, hide price and discount-related fields
    if (planType === 'free') {
      hideField('price_monthly');
      hideField('price_yearly');
      hideField('discount');
      hideField('discount_type');
      hideField('discount_percentage');
    } else { // If the plan type is paid
      showField('price_monthly');
      showField('price_yearly');
      showField('discount');
      showField('discount_type');
      showField('discount_percentage');
    }
  }

  function hideField(fieldId) {
    var field = document.getElementById('plan_' + fieldId);
    if (field) {
      field.closest('.input').style.display = 'none';
    }
  }

  function showField(fieldId) {
    var field = document.getElementById('plan_' + fieldId);
    if (field) {
      field.closest('.input').style.display = '';
    }
  }

  // Discount Calculation
  var priceMonthlyField = document.getElementById('plan_price_monthly');
  var priceYearlyField = document.getElementById('plan_price_yearly');
  var discountTypeField = document.getElementById('plan_discount_type');
  var discountPercentageField = document.getElementById('plan_discount_percentage');
  var discountField = document.getElementById('plan_discount');
  var discountedPriceMonthlyField = document.getElementById('discounted_price_monthly');
  var discountedPriceYearlyField = document.getElementById('discounted_price_yearly');

  [priceMonthlyField, priceYearlyField, discountTypeField, discountPercentageField, discountField].forEach(function(field) {
    field.addEventListener('input', calculateDiscountedPrices);
  });

  function calculateDiscountedPrices() {
    var priceMonthly = parseFloat(priceMonthlyField.value) || 0;
    var priceYearly = parseFloat(priceYearlyField.value) || 0;
    var discountPercentage = parseFloat(discountPercentageField.value) || 0;
    var discountType = discountTypeField.value;
    var hasDiscount = discountField.value === 'true';

    var discountedPriceMonthly = priceMonthly;
    var discountedPriceYearly = priceYearly;

    if (hasDiscount) {
      if (discountType === 'Percentage') {
        discountedPriceMonthly = priceMonthly - (priceMonthly * (discountPercentage / 100));
        discountedPriceYearly = priceYearly - (priceYearly * (discountPercentage / 100));
      } else if (discountType === 'Fixed') {
        discountedPriceMonthly = priceMonthly - discountPercentage;
        discountedPriceYearly = priceYearly - discountPercentage;
      }
    }

    discountedPriceMonthlyField.value = discountedPriceMonthly.toFixed(2);
    discountedPriceYearlyField.value = discountedPriceYearly.toFixed(2);
  }
});