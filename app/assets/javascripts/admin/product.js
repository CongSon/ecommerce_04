$(document).on('turbolinks:load', function () {
  $('#product_category_id').addClass('form-control');
});

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  var specifications = document.getElementsByClassName('specification_field');
  if(specifications.length < 4)
    $(link).parent().before(content.replace(regexp, new_id));
  else {
    alert(I18n.t('specification_not_more_4'))
  }
}

function remove_fields(link) {
  var specification = $(link).parent().parent();
  var specifications = document.getElementsByClassName('specification_field');
  if(specifications.length > 2){
    $(link).prev('input[type=hidden]').value = '1';
    $(link).closest('.form-group').remove();
  }
  else{
    alert(I18n.t('specification_not_less_2'))
  }
}
