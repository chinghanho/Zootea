+function ($) {
  'use strict';

  // AUTOCOMPLETE DRINKS DEFINITION
  // ==============================

  var Autocomplete = function (element) {
    this.$element = $(element);
  };

  Autocomplete.version = '0.0.1';

  Autocomplete.prototype.init = function () {

    var states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
      'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii',
      'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
      'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
      'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
      'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',
      'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
      'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
      'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
    ];

    // constructs the suggestion engine
    var states = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      // `states` is an array of state names defined in "The Basics"
      local: $.map(states, function(state) { return { value: state }; })
    });

    // kicks off the loading/processing of `local` and `prefetch`
    states.initialize();

    this.$element.typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      name: 'states',
      displayKey: 'value',
      // `ttAdapter` wraps the suggestion engine in an adapter that
      // is compatible with the typeahead jQuery plugin
      source: states.ttAdapter()
    });
  }

  // AUTOCOMPLETE PLUGIN DEFINITION
  // ==============================

  function Plugin(option) {
    return this.each(function () {
      var $this = $(this);
      var data  = $this.data('zt.autocomplete');

      if (!data) { $this.data('zt.autocomplete', (data = new Autocomplete(this))); }
      if (typeof option == 'string') { data[option](); }
    });
  }

  var old = $.fn.autocomplete;

  $.fn.autocomplete = Plugin;
  $.fn.autocomplete.Constructor = Autocomplete;

  // AUTOCOMPLETE NO CONFLICT
  // ========================

  $.fn.autocomplete.noConflict = function () {
    $.fn.autocomplete = old;
    return this;
  }

  // AUTOCOMPLETE DATA-API, LET'S GO!
  // ================================

  var autocompleteData = '[data-toggle="autocomplete"]';

  $(document)
    .ready(function () {
      Plugin.call($(autocompleteData), 'init');
    });

}(jQuery);
