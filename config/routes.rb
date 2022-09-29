Rails.application.routes.draw do
  devise_for :users

  root "events#index"
  resources :events, only: [:index, :new, :create, :show]
  get "/events/attend/:event_id", to: "events#attend", :as => :attend
  post "/events/search", to: "events#search", :as => :event_search
  get "/events/display_search", to: "events#display_search", :as => :display_search
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
