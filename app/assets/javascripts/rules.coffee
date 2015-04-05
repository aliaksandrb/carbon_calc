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
          "<option value='" + value + "'>" + value + "</option>"
        )
      )

      options_dropdown.empty()
      options_dropdown.html(options.join(''))
    )

  set_fields_for_category = (category_id) ->
    $.ajax({
      url: '/fields',
      data: {
        category_id: category_id,
        format: 'json'
      },
      dataType: 'JSON'
    }).success((data) ->
      fields_dropdown = $('#rule_field_name')
      options = []

      $.each(data, (index, value) ->
        options.push(
          "<option data-type='" + value.field_type + "' value='" + value.id + "'>" + value.name + "</option>"
        )
      )

      fields_dropdown.empty()
      fields_dropdown.html(options.join('')).change()
    )

  set_type_for_field_name = (field_type) ->
    $('#rule_field_type').val(field_type).change()


  if $("form[id^='edit_rule_']").size() > 0
    category_dropdown = $('#rule_category')
  else
    category_dropdown = $('#rule_category_id')

  if category_dropdown.size() > 0
    set_fields_for_category(category_dropdown.val())

    category_dropdown.on('change', ->
      set_fields_for_category(this.value)
    )

    fields_dropdown = $('#rule_field_name')
    if fields_dropdown.size() > 0
      fields_dropdown.on('change', ->
        set_type_for_field_name($('#rule_field_name').find("option:selected").data('type'))
      )

      field_type_dropdown = $('#rule_field_type')
      field_type_dropdown.on('change', ->
        set_operations_for_field_type(this.value.toLowerCase())
      )
)
