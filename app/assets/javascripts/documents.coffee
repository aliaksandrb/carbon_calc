$( ->
  add_fiedls_to_panel = (category_id) ->
    $.ajax({
      url: '/fields',
      data: {
        category_id: category_id,
        format: 'json'
      },
      dataType: 'JSON'
    }).success((data) ->
      panel = $('.data-panel')
      fields = []

      $.each(data, (index, value) ->
        capitalized_name = value.name.charAt(0).toUpperCase() + value.name.slice(1).toLowerCase()
        field_type = value.field_type.toLowerCase()

        selector = $('<select class="select required form-control"' +
          'name="document[data[' + value.name + ']]" id="field_' + value.name + '">'
        ).append('<option value="true">true</option>')
        .append('<option value="false">false</option>')

        switch field_type
          when 'integer'
            field_type = 'number'
          when 'boolean'
            field_type = 'boolean'
          else
            field_type = 'text'

        error = errors['document_' + value.name]
        if error
          if field_type == 'boolean'
            fields.push(
              '<div class="form-group ' + field_type + ' optional field_' + value.name + ' has-error">' +
                '<label class="string optional control-label" for="field_' + value.name + '">' +
                  capitalized_name + ' : ' + field_type +
                '</label>' +
                selector.prop('outerHTML') +
                error.prop('outerHTML') +
              '</div>'
            )
          else
            fields.push(
              '<div class="form-group ' + field_type + ' optional field_' + value.name + ' has-error">' +
                '<label class="string optional control-label" for="field_' + value.name + '">' +
                  capitalized_name + ' : ' + field_type +
                '</label>' +
                '<input class="string optional form-control"' +
                  'name="document[data[' + value.name + ']]" id="field_' + value.name +
                  '" type="' + field_type + '">' +
                error.prop('outerHTML') +
              '</div>'
            )
        else
          if field_type == 'boolean'
            fields.push(
              '<div class="form-group ' + field_type + ' optional field_' + value.name + '">' +
              '<label class="string optional control-label" for="field_' + value.name + '">' +
                capitalized_name + ' : ' + field_type +
              '</label>' +
              selector.prop('outerHTML') + '</div>'
            )
          else
            fields.push(
              '<div class="form-group ' + field_type + ' optional field_' + value.name + '">' +
              '<label class="string optional control-label" for="field_' + value.name + '">' +
                capitalized_name + ' : ' + field_type +
              '</label><input class="string optional form-control"' +
                'name="document[data[' + value.name + ']]" id="field_' + value.name +
                '" type="' + field_type + '"></div>'
            )
      )

      panel.html(fields.join(''))
    )

  dropdown = $('#document_category_id')
  errors = {}

  if dropdown.size() > 0
    unless $("form[id^='edit_document_']").size() > 0
      fields_with_error = $('.has-error').each((index, field) ->
        errors[$(field).find('label').prop('for')] = $(field).find('span.help-block')
      )

      add_fiedls_to_panel(dropdown.val())

    dropdown.on('change', ->
      add_fiedls_to_panel(this.value)
    )
)
