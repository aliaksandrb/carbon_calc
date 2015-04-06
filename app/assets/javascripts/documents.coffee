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
        if field_type == 'integer'
          field_type = 'number'
        else
          field_type = 'text'

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

  if dropdown.size() > 0
    unless $("form[id^='edit_document_']").size() > 0
      add_fiedls_to_panel(dropdown.val())

    dropdown.on('change', ->
      add_fiedls_to_panel(this.value)
    )
)
