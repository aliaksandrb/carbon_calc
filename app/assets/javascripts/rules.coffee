$( ->
  set_operations_for_field_type = (field_type) ->
    $.ajax({
      url: '/rules/get_operations',
      data: {
        field_type: field_type,
        format: 'json'
      },
      dataType: 'JSON'
    }).success((data) ->
      options_dropdown = $('#rule_operation')
      options = []


      $.each(data[field_type], (index, value) ->
        options.push(
          '<option value="' + value + '">' + value + '</option>'
        )
      )

      options_dropdown.html(options.join(''))
    )

  field_type_dropdown = $('#rule_field_type')

  set_operations_for_field_type(field_type_dropdown.val())

  field_type_dropdown.on('change', ->
    set_operations_for_field_type(this.value.toLowerCase())
  )
)
