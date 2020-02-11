Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'search_cabs', to: 'cabs#search_cabs'
end
