Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  
  devise_for :users
  
  post "/graphql", to: "graphql#execute", as: 'graphql'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
