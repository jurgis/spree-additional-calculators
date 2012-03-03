class SpreeAdditionalCalculatorsHooks < Spree::ThemeSupport::HookListener

  # Admin Congiration Item
  Deface::Override.new( :virtual_path => "admin/configurations/index",
                        :name => "converted_admin_configurations_menu_133293197",
                        :insert_after => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
                        :text => "<%= configurations_menu_item(I18n.t('additional_calculator_rates'), admin_additional_calculator_rates_path, I18n.t('additional_calculator_rates_description')) %>",
                        :disabled => false)

  # Additional JavaScript
  Deface::Override.new( :virtual_path => "layouts/admin",
                        :name => "converted_admin_inside_head_650753510",
                        :insert_after => "[data-hook='admin_inside_head'], #admin_inside_head[data-hook]",
                        :partial => "shared/additional_calculators_admin_head",
                        :disabled => false)
end