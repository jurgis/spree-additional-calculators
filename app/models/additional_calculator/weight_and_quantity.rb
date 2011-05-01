class AdditionalCalculator::WeightAndQuantity < AdditionalCalculator::Base
  # if weight is not defined for an item, use this instead
  preference :default_item_weight, :decimal, :default => 0

  # The description of the calculator
  def self.description
    I18n.t('calculator_names.weight_and_quantity')
  end

  # as order_or_line_items we always get line items, as calculable we have ShippingMethod
  def compute(order_or_line_items)
    line_items = order_to_line_items(order_or_line_items)
    total_qnty = get_total_qnty(line_items)
    weight_rate = get_rate(get_total_weight(line_items), AdditionalCalculatorRate::WEIGHT)

    # NOTE: Maybe that has been fixed in the spree 0.50.x
    # # sometimes the compute method is called without checking if the calculator is available
    # if weight_rate.nil?
    #   logger.warn("The calculator's #{name} weight_rate is nil - returning. Availability is not checked!")
    #   return nil
    # end

    # quantity rate might be nil if the specified range is not available
    qnty_rate = get_rate(total_qnty, AdditionalCalculatorRate::QNTY)
    # find the previous qnty rate or set it to 0 if not found
    qnty_rate = get_previous_rate(total_qnty, AdditionalCalculatorRate::QNTY) || 0 if qnty_rate.nil?

    # the total rate is sum of weight and quantity rates
    total_rate = weight_rate + qnty_rate
    logger.debug("The calculator '#{name}' weight_rate: #{weight_rate.inspect}, qnty_rate: #{qnty_rate.inspect}, total: #{total_rate}")

    total_rate
  end

  # check if this calculator is available for the Order
  def available?(order_or_line_items)
    line_items = order_to_line_items(order_or_line_items)
    weight_rate = get_rate(get_total_weight(line_items), AdditionalCalculatorRate::WEIGHT)

    available = !weight_rate.nil? # available only if the weight rate is not nil
    logger.debug("The calculator '#{name}' is available: #{available}")

    available
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
