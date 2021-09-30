# frozen_string_literal: true

Rails.application.routes.draw do
  resources :audits, only: [:index]
  resources :elections do
    get 'audits'
    resources :questions, shallow: true do
      get 'audits'
      resources :answers, shallow: true do
        get 'audits'
      end
    end
    resources :voters, shallow: true do
      get 'audits'
      get :ballot, on: :member
      post :submit, on: :member
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
