// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require social-share-button
//= require_tree .
//= require bootstrap
//= require jquery.raty
//= require ratyrate

$(document).on('turbolinks:load', function () {
  var data = {};
    $('.cart-quantity').each(function(){
      $(this).bind('keyup change click', function (e) {
        event.preventDefault();
        var id = $(this).attr('data');
        var quantity = parseInt($('#quantity-' + id).val(), 10);
        var price = parseFloat($('#price-' + id).text().trim());
        $('#total-' + id).text(quantity * price);
        data[id] = quantity;
      });
    });

  $('#update-cart').click(function(){
    if(Object.keys(data).length != 0){
      $.ajax({
        url: '/cart/',
        data: {
          cart: data
        },
        method: 'PATCH',
        success: function(result){
        }
      });
    }
  });
});
