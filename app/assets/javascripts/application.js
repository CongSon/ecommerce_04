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

  $('a#fav.inactive').bind('click', addFav);
  $('a#fav.active').bind('click', removeFav);
});
function addFav(){
  var product_id = $('.favorite-product').attr('data')
  $.ajax({
    url: '/favorite_products/',
    data: {product_id: product_id},
    method: 'POST',
    success: function(){
      $('a#fav')
        .removeClass('inactive')
        .addClass('active')
        .attr('title','[-] Remove from favorites')
        .unbind('click')
        .bind('click', removeFav)
       ;
    }
  });
}

function removeFav(){
  var product_id = $('.favorite-product').attr('data')
  $.ajax({
    url: '/favorite_products/' + product_id,
    data: {product_id: product_id},
    method: 'DELETE',
    success: function(){
      $('a#fav')
        .removeClass('active')
        .addClass('inactive')
        .attr('title','[+] Add as favorite')
        .unbind('click')
        .bind('click', addFav)
      ;
    }
  });
}
