module Spree
  class Admin::AdditionalCalculatorRatesController < Admin::BaseController
    # resource_controller - not using because too much customization required
    helper Admin::AdditionalCalculatorsHelper

    before_filter :load_calculator, :only => [:edit, :update]

    def index
      @calculators = Calculator.where(:is_additional_calculator => true).order('created_at DESC')
    end

    def edit
      @rates_by_type = get_rates_by_type(@calculator)
    end

    def update
      if @calculator.update_attributes(params[:additional_calculator_weight_and_quantity]) # TODO: this must be changed!!!
        flash[:notice] = t('resource_controller.successfully_updated')
        redirect_to edit_admin_additional_calculator_rate_url(@calculator)
      else
        @rates_by_type = get_rates_by_type(@calculator, false) # set @rates_by_type before rendering the view
        render :action => 'edit'
      end
    end

    private

    def load_calculator
      @calculator = Calculator.find(params[:id])
    end

    def get_rates_by_type(calculator, load_from_db = true)
      rates_by_type = {}
      calculator.supported_types.each { |type| rates_by_type[type] = [] }
      rates = load_from_db ? calculator.sorted_rates : calculator.additional_calculator_rates
      rates.each { |rate| rates_by_type[rate.rate_type] << rate }
      rates_by_type
    end
  end
end
