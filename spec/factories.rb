Factory.define :shipping_method do |f|
  f.name "Test Shipping Method"
  f.zone { Zone.first }
end

Factory.define :weight_and_quantity_calculator, :class => AdditionalCalculator::WeightAndQuantity do |f|
  f.calculable { ShippingMethod.first }
  f.is_additional_calculator true
end


Factory.define :additional_calculator_rate do |f|
  f.calculator { Calculator.where(:is_additional_calculator => true).order(:id).last }
end

Factory.define :additional_calculator_rate_for_weight, :class => AdditionalCalculatorRate,  do |f|
  f.calculator { Calculator.where(:is_additional_calculator => true).order(:id).last }
  f.calculator_type 'Calculator'
  f.rate_type AdditionalCalculatorRate::WEIGHT
end
