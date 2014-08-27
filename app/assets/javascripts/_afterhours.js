+function ($) {
  'use strict';

  // AFTERHOURS CLASS DEFINITION
  // ===========================

  var AfterHours = function (element) {
    this.$element = $(element);
    this.$target  = $('.' + this.$element.data('target'));
  };

  AfterHours.version = '0.0.1';

  AfterHours.prototype.init = function () {
    var value = this.$element.val();
    var text  = this.$target.text();
    var time  = moment(text, 'hh:mm').calendar()
    this.$target.text(time);
  };

  AfterHours.prototype.showtime = function () {
    var value = this.$element.val();
    var time  = moment().add('s', value).calendar();
    this.$target.text(time);
  };


  // AFTERHOURS PLUGIN DEFINITION
  // ============================

  function Plugin(option) {
    return this.each(function () {
      var $this = $(this);
      var data  = $this.data('zt.afterhours');

      if (!data) { $this.data('zt.afterhours', (data = new AfterHours(this))); }
      if (typeof option == 'string') { data[option](); }
    })
  }

  var old = $.fn.afterhours;

  $.fn.afterhours             = Plugin;
  $.fn.afterhours.Constructor = AfterHours;


  // AFTERHOURS NO CONFLICT
  // ======================

  $.fn.afterhours.noConflict = function () {
    $.fn.afterhours = old;
    return this;
  };


  // AFTERHOURS DATA-API, LET'S GO!
  // =============================

  var afterhoursData = '[data-toggle="afterhours"]';

  var ready = function () {
    Plugin.call($(afterhoursData), 'init');
  }

  $(document)
    .on('ready', ready)
    .on('page:load', ready)
    .on('change.zt.afterhours.data-api', afterhoursData, function (e) {
      e.preventDefault();
      Plugin.call($(this), 'showtime');
    });

}(jQuery);
