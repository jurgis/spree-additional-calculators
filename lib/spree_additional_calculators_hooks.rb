class SpreeAdditionalCalculatorsHooks < Spree::ThemeSupport::HookListener
  # custom hooks go here

  # Add a link on admin configuration page
  insert_after :admin_configurations_menu do
    %(<%= configurations_menu_item(t("additional_calculator_rates"), admin_additional_calculator_rates_path, t("additional_calculator_rates_description")) %>)
  end

  # Add js file to the head section
  insert_after :admin_inside_head, 'shared/additional_calculators_admin_head'

end
