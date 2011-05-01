require 'spree_core'
require 'spree_additional_calculators_hooks'

module SpreeAdditionalCalculators
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      #register all calculators
      [
        AdditionalCalculator::WeightAndQuantity
      ].each do |c_model|
        begin
          c_model.register if c_model.table_exists?
        rescue Exception => e
          $stderr.puts "Error registering calculator #{c_model}"
        end
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
