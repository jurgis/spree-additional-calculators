module SpreeAdditionalCalculators
  class Engine < Rails::Engine
    engine_name 'spree_additional_calculators'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/**/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

    initializer "spree_additional_calculators.register.calculators" do |app|
      app.config.spree.calculators.shipping_methods.concat([Spree::AdditionalCalculator::WeightAndQuantity])
    end
  end
end
