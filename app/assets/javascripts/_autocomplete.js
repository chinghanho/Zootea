+function ($) {
  'use strict';

  // AUTOCOMPLETE DRINKS DEFINITION
  // ==============================

  var Autocomplete = function (element) {
    this.$element = $(element);
    this.data     = this.$element.data('target');
  };

  Autocomplete.version = '0.0.1';

  Autocomplete.prototype.init = function () {

    var dataset = this.data;

    // constructs the suggestion engine
    var dataset = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: $.map(dataset, function(data) { return { value: data }; })
    });

    // kicks off the loading/processing of `local` and `prefetch`
    dataset.initialize();

    this.$element.typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      name: 'dataset',
      displayKey: 'value',
      // `ttAdapter` wraps the suggestion engine in an adapter that
      // is compatible with the typeahead jQuery plugin
      source: dataset.ttAdapter()
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

  var ready = function () {
    Plugin.call($(autocompleteData), 'init');
  }

  $(document)
    .on('ready', ready)
    .on('page:load', ready);

}(jQuery);
