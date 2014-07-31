+function ($) {
  'use strict';

  // DROPZONE CLASS DEFINITION
  // =========================

  var Dropzone = function (element) {
    this.$element = $(element);
  };

  Dropzone.version = '0.0.1';

  Dropzone.prototype.init = function () {
    $.event.props.push("dataTransfer");
  };


  Dropzone.prototype.onDragover = function () {
    this.$element.addClass('dragged');
  };


  Dropzone.prototype.onDragleave = function () {
    this.$element.removeClass('dragged');
  }


  Dropzone.prototype.onDrop = function () {

    var file = event.dataTransfer.files[0];
    var fd = new FormData();
    fd.append('file', file);


    function uploadProgress(evt) {
      if (evt.lengthComputable) {
        $('.bar').css('width', Math.round(evt.loaded * 100 / evt.total) + '%');
      } else {
        $('.bar').html('<p>Can not compute...</p>');
      }
    }

    function uploadComplete(evt) {
      $('.progress').remove();
      var callback = $.parseJSON(evt.target.responseText);
      if (callback.status == 'success') {
        scope.resourceModel.img_url = callback.url;
      }
      else {
        console.log('upload failed');
      }
    }

    function uploadFailed() {
      console.log('There was an error attempting to upload the file.');
    }

    function uploadCanceled() {
      console.log('The upload has been canceled by the user or the browser dropped the connection.');
    }

    /**
     *
     * XHR
     *
     */
    var xhr = new XMLHttpRequest();
    xhr.upload.addEventListener('progress', uploadProgress, false);
    xhr.addEventListener('load', uploadComplete, false);
    xhr.addEventListener('error', uploadFailed, false);
    xhr.addEventListener('abort', uploadCanceled, false);
    xhr.open('POST', '/api/resources/image');
    // xhr.setRequestHeader('X-CSRF-TOKEN', $cookies['XSRF-TOKEN']);
    xhr.send(fd);


    $('<div class="progress progress-striped active"><div class="bar"></div></div>')
      .insertBefore('.modal__cover-image');


    /**
     *
     * FileReader
     *
     */
    var reader = new FileReader();

    reader.onload = (function(theFile) {
      return function(e) {
        var division = document.createElement('div');
        division.innerHTML = ['<img class="thumb" src="', e.target.result, '" title="', escape(theFile.name), '"/>'].join('');
        $('#upload-cover-image').html(division);
        $('#upload-cover-image').addClass('dropped');
      };
    })(file);

    reader.readAsDataURL(file);
  };


  // DROPZONE PLUGIN DEFINITION
  // ==========================

  function Plugin(option) {
    return this.each(function () {
      var $this = $(this);
      var data  = $this.data('zt.dropzone');

      if (!data) { $this.data('zt.dropzone', (data = new Dropzone(this))); }
      if (typeof option == 'string') { data[option](); }
    })
  }

  var old = $.fn.dropzone;

  $.fn.dropzone             = Plugin;
  $.fn.dropzone.Constructor = Dropzone;


  // DROPZONE NO CONFLICT
  // ====================

  $.fn.dropzone.noConflict = function () {
    $.fn.dropzone = old;
    return this;
  };


  // DROPZONE DATA-API, LET'S GO!
  // ===========================

  var dropzoneData = '[data-toggle="dropzone"]';

  $(document)
    .ready(function () {
      Plugin.call($(dropzoneData), 'init');
    })
    .on('dragover.zt.afterhours.data-api', dropzoneData, function (e) {
      e.preventDefault();
      e.stopPropagation();
      Plugin.call($(this), 'onDragover');
    })
    .on('dragleave.zt.afterhours.data-api', dropzoneData, function (e) {
      e.preventDefault();
      e.stopPropagation();
      Plugin.call($(this), 'onDragleave');
    })
    .on('drop.zt.afterhours.data-api', dropzoneData, function (e) {
      e.preventDefault();
      e.stopPropagation();
      Plugin.call($(this), 'onDrop');
    });

}(jQuery);
