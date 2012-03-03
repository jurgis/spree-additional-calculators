module SpreeAdditionalCalculators
  class Engine < Rails::Engine
    engine_name 'spree_additional_calculators'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree_additional_calculators.register.calculators" do |app|
      app.config.spree.calculators.shipping_methods.concat([Spree::AdditionalCalculator::WeightAndQuantity])
    end
  end
end
