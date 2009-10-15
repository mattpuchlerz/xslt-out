var Autopilot = new Class({
  
  Implements: [ Options ],
  
  checkbox: null,
  form: null,
  formTimer: null,
  label: null,
  lastRequestTime: null,
  
  options: {
    classes: {
      loading: 'autopilot-loading'
    },
    delay: 2000,
    update: null
  },
  
  initialize: function(form, options) {
    this.setOptions(options);
    this.setupForm(form);
    this.createElements();
    this.checkbox.addEvent('change', this.toggleFormAutopilot.bindWithEvent(this));
    Autopilot.instances++;
  },
  
  createElements: function() {
    this.label = new Element('label', {
      'class': 'autopilot', 
      'for':   'autopilot' + Autopilot.instances,
      'html':  '<input id="autopilot' + Autopilot.instances + '" type="checkbox" name="autopilot" /> Autopilot'
    });
    this.label.inject(this.form);
    this.checkbox = this.label.getElement('input');
  },
  
  hideLoader: function() {
    // Make sure that the loader is shown for at least 500 milliseconds
    var delay = 500 - ($time() - this.lastRequestTime);
    if (delay < 0) delay = 0;
    this.form.removeClass.delay(delay, this.form, this.options.classes.loading);
  },
  
  setupForm: function(form) {
    this.form = $(form);
    var newRequestInstance = new Request.HTML({ 
      'onComplete': this.hideLoader.bind(this),
      'onRequest':  this.showLoader.bind(this),
      'update':     this.options.update,
      'url':        this.form.get('action')
    });
    this.form.store('send', newRequestInstance);
  },
  
  showLoader: function() {
    this.lastRequestTime = $time();
    this.form.addClass(this.options.classes.loading);
  },
  
  toggleFormAutopilot: function() {
    if ( this.checkbox.get('checked') )
      this.formTimer = this.form.send.periodical(this.options.delay, this.form);
    else
      $clear(this.formTimer);
    this.checkbox.blur();
  }
  
});

Autopilot.instances = 0;