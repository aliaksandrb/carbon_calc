$( ->

  set_field_type = (old_field, type) ->
    field = $('#field_default_value')

    switch type
      when 'Integer'
        field.replaceWith(old_field.prop('type', 'number'))
      when 'Boolean'
        field.replaceWith(selector).select()
      else
        field.replaceWith(old_field.prop('type', 'text'))

  if $('form#new_field').size() > 0 || $("form[id^='edit_field_']").size() > 0
    old_field = $('#field_default_value').clone()
    dropdown = $('select#field_field_type')
    selector = $('<select class="select required form-control"' +
      'name="field[default_value]" id="field_default_value">'
    ).append('<option value="true">true</option>')
    .append('<option value="false">false</option>')

    set_field_type(old_field, dropdown.val(), selector)

    dropdown.on('change', ->
      set_field_type(old_field, this.value, selector)
    )
)

