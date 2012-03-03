class CreateAdditionalCalculatorRates < ActiveRecord::Migration
  class Calculator < ActiveRecord::Base; end

  def self.up
    create_table :additional_calculator_rates do |t|
      t.integer :calculator_id,   :null => false
      t.string  :calculator_type, :null => false, :limit => 50
      t.integer :rate_type,       :null => false,                               :default => 0
      t.decimal :from_value,      :null => false, :precision => 8, :scale => 3, :default => 0.0
      t.decimal :to_value,        :null => false, :precision => 8, :scale => 3, :default => 0.0
      t.decimal :rate,            :null => false, :precision => 8, :scale => 2, :default => 0.0

      t.timestamps
    end

    add_index(:additional_calculator_rates, :calculator_id)
    add_index(:additional_calculator_rates, :calculator_type)
    add_index(:additional_calculator_rates, :rate_type)
    add_index(:additional_calculator_rates, :from_value)
    add_index(:additional_calculator_rates, :to_value)

    # Support for Spree < 1.0.0
    if Calculator.table_exists?
      add_column(:calculators, :is_additional_calculator, :boolean, :default => false)
      add_index(:calculators, :is_additional_calculator)
    else
      add_column(:spree_calculators, :is_additional_calculator, :boolean, :default => false)
      add_index(:spree_calculators, :is_additional_calculator)
    end
  end

  def self.down
    remove_index(:additional_calculator_rates, :calculator_id)
    remove_index(:additional_calculator_rates, :calculator_type)
    remove_index(:additional_calculator_rates, :rate_type)
    remove_index(:additional_calculator_rates, :from_value)
    remove_index(:additional_calculator_rates, :to_value)
    drop_table(:additional_calculator_rates)

    # Support for Spree < 1.0.0
    if Calculator.table_exists?
      remove_index(:calculators, :is_additional_calculator)
      remove_column(:calculators, :is_additional_calculator)
      else
      remove_index(:spree_calculators, :is_additional_calculator)
      remove_column(:spree_calculators, :is_additional_calculator)
    end
  end
end
