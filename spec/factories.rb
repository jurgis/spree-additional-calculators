# -------------------------------------- sequences --------------------------------------


Factory.sequence(:email_sequence) {|n| "user#{n}@example.com"}
Factory.sequence(:sku_sequence) {|n| n}
Factory.sequence(:product_sequence) {|n| "Product ##{n} - #{rand(9999)}"}


# -------------------------------------- shipping_method --------------------------------------


Factory.define :shipping_method do |f|
  f.name 'Test Shipping Method'
  f.zone { Zone.first }
end


# -------------------------------------- calculators --------------------------------------


Factory.define :weight_and_quantity_calculator, :class => AdditionalCalculator::WeightAndQuantity do |f|
  f.calculable { ShippingMethod.first }
  f.is_additional_calculator true
end


# -------------------------------------- additional_calculator_rate --------------------------------------


Factory.define :additional_calculator_rate_for_weight, :class => AdditionalCalculatorRate,  do |f|
  f.calculator { Calculator.where(:is_additional_calculator => true).order(:id).last }
  f.calculator_type 'Calculator'
  f.rate_type AdditionalCalculatorRate::WEIGHT
end


Factory.define :additional_calculator_rate_for_qnty, :class => AdditionalCalculatorRate,  do |f|
  f.calculator { Calculator.where(:is_additional_calculator => true).order(:id).last }
  f.calculator_type 'Calculator'
  f.rate_type AdditionalCalculatorRate::QNTY
end


# -------------------------------------- orders --------------------------------------


Factory.define :order do |f|
  f.association(:user, :factory => :user)
  f.association(:bill_address, :factory => :address)
  f.completed_at nil
  f.bill_address_id nil
  f.ship_address_id nil
end


Factory.define :order_with_one_item, :parent => :order do |f|
  f.after_create { |order| Factory(:line_item, :order => order) }
end

Factory.define :order_with_two_items, :parent => :order do |f|
  f.after_create do |order|
    Factory(:line_item, :order => order)
    Factory(:line_item, :order => order)
  end
end

Factory.define :order_with_items_without_weight, :parent => :order do |f|
  f.after_create { |order| Factory(:line_item_without_weight, :order => order) }
end


# -------------------------------------- line_items --------------------------------------


Factory.define(:line_item) do |f|
  f.quantity 1
  f.price { BigDecimal.new("10.00") }

  # associations:
  f.association(:order, :factory => :order)
  f.association(:variant, :factory => :variant)
end

Factory.define(:line_item_without_weight, :parent => :line_item) do |f|
  # associations:
  f.association(:order, :factory => :order)
  f.association(:variant, :factory => :variant_without_weight)
end


# -------------------------------------- variants --------------------------------------


Factory.define(:variant) do |f|
  f.price 19.99
  f.cost_price 17.00
  f.sku { Factory.next(:sku_sequence) }
  f.weight { BigDecimal.new("#{rand(200)}.#{rand(99)}") }
  # f.height { BigDecimal.new("#{rand(200)}.#{rand(99)}") }
  # f.width  { BigDecimal.new("#{rand(200)}.#{rand(99)}") }
  # f.depth  { BigDecimal.new("#{rand(200)}.#{rand(99)}") }

  # associations:
  f.product { |p| p.association(:product) }
  # f.option_values { [Factory(:option_value)] }
end


Factory.define(:variant_without_weight, :parent => :variant) do |f|
  f.weight nil
end


# -------------------------------------- products --------------------------------------


Factory.define :product do |f|
  f.name { Factory.next(:product_sequence) }
  f.description {|p| p.name }

  # associations:
  # f.tax_category {|r| TaxCategory.find(:first) || r.association(:tax_category)}
  # f.shipping_category {|r| ShippingCategory.find(:first) || r.association(:shipping_category)}

  f.price 19.99
  f.cost_price 17.00
  f.sku "ABC"
  f.available_on { 1.year.ago }
  f.deleted_at nil
end


# -------------------------------------- users --------------------------------------


Factory.define(:user) do |f|
  f.email { Factory.next(:email_sequence) }
  f.password 'password'
  f.password_confirmation 'password'
end


# -------------------------------------- addresses --------------------------------------


Factory.define :address do |f|
  f.firstname 'John'
  f.lastname 'Doe'
  f.address1 '10 Lovely Street'
  f.address2 'Northwest'
  f.city   "Herndon"
  f.zipcode '20170'
  f.phone '123-456-7890'
  f.alternative_phone "123-456-7899"

  f.state  { |address| address.association(:state) }
  f.country do |address|
    if address.state
      address.state.country
    else
      address.association(:country)
    end
  end
end


# -------------------------------------- states --------------------------------------


Factory.define :state do |f|
  f.name 'ALABAMA'
  f.abbr 'AL'
  f.country do |country|
    if usa = Country.find_by_numcode(840)
      country = usa
    else
      country.association(:country)
    end
  end
end
