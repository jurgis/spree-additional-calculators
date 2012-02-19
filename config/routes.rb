Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :additional_calculator_rates, :only => [ :index, :edit, :update ]
  end
end
