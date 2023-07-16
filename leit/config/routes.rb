# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :boxes, only: %i[show index]
  resources :flashcards, only: %i[show index]
  resources :studycards, only: %i[show index]
  ActiveAdmin.routes(self)
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  devise_for :users

  post '/graphql', to: 'graphql#execute', as: 'graphql'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
