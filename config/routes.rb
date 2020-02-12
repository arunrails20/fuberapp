# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'search_cabs', to: 'cabs#search_cabs'
  post 'book_ride', to: 'rides#book'
end
