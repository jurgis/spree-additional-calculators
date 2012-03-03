# Admin Congiration Item
Deface::Override.new( :virtual_path => "spree/admin/configurations/index",
                      :name => "converted_admin_configurations_menu_133293197",
                      :insert_after => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
                      :text => "<%= configurations_menu_item(I18n.t('additional_calculator_rates'), admin_additional_calculator_rates_path, I18n.t('additional_calculator_rates_description')) %>",
                      :disabled => false)