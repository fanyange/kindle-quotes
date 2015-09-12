$(document).ready(function() {
$('.message .close')
.on('click', function() {
  $(this)
    .closest('.message')
    .transition('fade')
    ;
});

$('select.dropdown').dropdown();

$('.note').closest('.card').addClass('has-notes');
});
