module Spree
  class AdditionalCalculator::WeightAndQuantity < AdditionalCalculator::Base
    # if weight is not defined for an item, use this instead
    preference :default_item_weight, :decimal, :default => 0

    # The description of the calculator
    def self.description
      I18n.t('calculator_names.weight_and_quantity')
    end

    # object can be [Order, Shipment] and maybe something else ...
    def compute(object)
      line_items = object_to_line_items(object)
      return nil if line_items.nil?

      total_qnty = get_total_qnty(line_items)
      total_weight = get_total_weight(line_items)
      weight_rate = get_rate(total_weight, AdditionalCalculatorRate::WEIGHT)

      # sometimes the compute method is called without checking if the calculator is available
      if weight_rate.nil?
        logger.warn("The calculator's #{name} weight_rate is nil - returning. Availability is not checked!")
        return nil
      end

      # quantity rate might be nil if the specified range is not available
      qnty_rate = get_rate(total_qnty, AdditionalCalculatorRate::QNTY)
      # find the previous qnty rate or set it to 0 if not found
      previous_qnty_rate = get_previous_rate(total_qnty, AdditionalCalculatorRate::QNTY)

      # the total rate is sum of weight and quantity rates
      # the rate is available if
      # 1) qnty_rate is not nil
      # 2) qnty_rate is nil AND previous_qnty_rate is nil (quantity configuration not defined at all)
      if !qnty_rate.nil?
        weight_rate + qnty_rate
      elsif previous_qnty_rate.nil?
        weight_rate
      else
        nil
      end
    end

    # check if this calculator is available for the Order
    def available?(object)
      !self.compute(object).nil?
    end

    protected

    # get total weight of the order
    def get_total_weight(line_items)
      line_items.map do |li|
        # use default item weight if the weight is not defined for a product
        item_weight = li.variant.weight.nil? ? self.preferred_default_item_weight : li.variant.weight
        item_weight * li.quantity
      end.sum
    end

    # get total item quantity of the order
    def get_total_qnty(line_items)
        line_items.map(&:quantity).sum
    end

  end
end
