class PrefixTableName < ActiveRecord::Migration
  def change
    rename_table :additional_calculator_rates, :spree_additional_calculator_rates
  end
end
