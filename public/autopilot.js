var Autopilot = new Class({
  
  Implements: [ Options ],
  
  checkbox: null,
  form: null,
  formTimer: null,
  
  options: {
    delay: 2000,
    update: null
  },
  
  initialize: function(form, options) {
    this.setOptions(options);
    this.setupForm(form);
    this.createCheckbox();
    this.checkbox.addEvent('change', this.checkboxEvent.bindWithEvent(this));
    Autopilot.instances++;
  },
  
  checkboxEvent: function(event) {
    if ( this.checkbox.get('checked') )
      this.formTimer = this.form.send.periodical(this.options.delay, this.form);
    else
      $clear(this.formTimer);
  },
  
  createCheckbox: function() {
    var label = new Element('label', {
      'class': 'autopilot', 
      'for':   'autopilot' + Autopilot.instances,
      'html':  '<input id="autopilot' + Autopilot.instances + '" type="checkbox" name="autopilot" /> Autopilot'
    });
    label.inject(this.form);
    this.checkbox = label.getElement('input');
  },
  
  setupForm: function(form) {
    this.form = $(form);
    var newRequestInstance = new Request.HTML({ 
      'update': this.options.update,
      'url':    this.form.get('action') 
    });
    this.form.store('send', newRequestInstance);
  }
  
});

Autopilot.instances = 0;