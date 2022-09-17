Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  get "/", to: 'health_checks#hello_palenca'
  get 'health', to: 'health_checks#health_check'
  
  
  api_guard_scope 'users' do
    scope ":platform" do
      post "login", to: "authentication#authentication", as: "login"
      get "profile/:access_token", to: "users#profile", as: "profile"
    end
  end
end
