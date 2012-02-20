module Spree
  class AdditionalCalculatorRate < ActiveRecord::Base

    # Types (0  is the default value for the column, therefore I'm not using it)
    WEIGHT = 1  # Total item weight
    QNTY = 2   # Total item quantity

    belongs_to :calculator

    scope :for_type, lambda {|type| where(:rate_type => type) }
    scope :for_calculator, lambda {|calculator_id| where(:calculator_id => calculator_id) }
    scope :for_value, lambda {|value| where("from_value <= ? AND ? <= to_value", value, value)}

    validates :calculator_id, :rate_type, :from_value, :to_value, :rate, :presence => true
    validates :from_value, :to_value, :rate, :numericality => true, :allow_blank => true
    validate :validate_from_value_smaller_than_to_value

    def validate_from_value_smaller_than_to_value
      # ignore following cases
      return if from_value.nil? || to_value.nil?

      errors.add(:base, I18n.t('errors.from_value_greater_than_to_value')) if from_value > to_value
    end

    # All complex calculator rate types
    def self.all_types
      [WEIGHT, QNTY]
    end

    # Find the rate for the specified value
    def self.find_rate(calculator_id, rate_type, value)
      # get the lowes rate if multiple rates are defined (overlap)
      rate = for_calculator(calculator_id).for_type(rate_type).for_value(value).order("rate").first()
      rate.nil? ? nil : rate.rate
    end

    # Find the previous rate for the specified value
    def self.find_previous_rate(calculator_id, rate_type, value)
      rate = for_calculator(calculator_id).for_type(rate_type).where("to_value < ?", value).order("rate DESC").first()
      rate.nil? ? nil : rate.rate
    end
  end
end
