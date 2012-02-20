module Spree
  class AdditionalCalculator::Base < Calculator
    has_many :additional_calculator_rates,
             :as => :calculator,
             :dependent => :destroy

    accepts_nested_attributes_for :additional_calculator_rates,
                                  :allow_destroy => true,
                                  :reject_if => lambda {|attr| attr[:from_value].blank? && attr[:to_value].blank? && attr[:rate].blank?}

    before_save :set_is_additional_calculator

    # Register the calculator
    def self.register
      super
      ShippingMethod.register_calculator(self)
    end

    # Return calculator name
    def name
      calculable.respond_to?(:name) ? calculable.name : calculable.to_s
    end

    # supported types for the specified calculator (weight, qnty, ...)
    # all the types are supported by default
    def supported_types
      AdditionalCalculatorRate.all_types
    end

    def sorted_rates
      additional_calculator_rates.order("rate_type ASC, from_value ASC")
    end

    protected

    # Get the rate from the database or nil if could not find the rate for the specified rate type
    def get_rate(value, rate_type)
      AdditionalCalculatorRate.find_rate(self.id, rate_type, value)
    end

    # Get the previous rate if rate for the specified value does not exist, return nil if no previous rate can be find
    def get_previous_rate(value, rate_type)
      AdditionalCalculatorRate.find_previous_rate(self.id, rate_type, value)
    end

    # Before saving the record set that this is the additional calculator
    def set_is_additional_calculator
      self.is_additional_calculator = true
    end

    # get the line items
    def object_to_line_items(object)
      return object.line_items if object.is_a?(Order)
      return object.send(:order).line_items if object.respond_to?(:order)
      nil
    end
  end
end
