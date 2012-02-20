module Spree
  module Admin::AdditionalCalculatorsHelper

    # Removes the rate fields
    def link_to_remove_additional_calculator_rate_fields(name, f)
      f.hidden_field(:_destroy) + link_to_function(name, 'remove_additional_calculator_rate_fields(this)')
    end

    # Adds the rate fields
    def link_to_add_additional_calculator_rate_fields(name, f, association, attributes ={})
      new_object = f.object.class.reflect_on_association(association).klass.new
      new_object.attributes = attributes

      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
      end

      link_to_function(name, %Q[add_additional_calculator_rate_fields(this, "#{association}", "#{escape_javascript(fields)}")])
    end

  end
end
