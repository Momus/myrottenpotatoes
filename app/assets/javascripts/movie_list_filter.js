var MovieListFilter = {
  filter_adult: function () {
    //'this' is the *unwrapped* element that recieved event (checkbox)
    if ($(this).is(':checked')) {
      $('tr.adult').hide();
    } else {
      $('tr.adult').show();
    };
  },
  setup: function () {
    //construct checkbox with label
    var labelAndCheckbox =
        $('<label for="filter">Only movies suitable for chidren</label>' +
          '<input type="checkbox" id="filter"/>'
         );
    labelAndCheckbox.insertBefore('#movies');
    $('#filter').change(MovieListFilter.filter_adult);
  }
}

$(MovieListFilter.setup); //run setup function on document ready
