//= require admin/spree_core

window.remove_additional_calculator_rate_fields = (link) ->
  $(link).prev("input[type=hidden]").val("1")
  $(link).closest(".additional_calculator_rate_fields").hide()

window.add_additional_calculator_rate_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).parent().parent().before(content.replace(regexp, new_id))
