Rails.application.routes.draw do
  devise_for :users

  root "events#index"
  get "/events/attend/:event_id", to: "events#attend", :as => :attend
  post "/events/search", to: "events#search", :as => :event_search
  get "/events/display_search", to: "events#display_search", :as => :display_search
  get "/events/event_chosen", to: "events#event_chosen", :as => :event_chosen
  get "/events/search_date", to: "events#search_date", :as => :search_date
  post "/events/show_by_date", to: "events#show_by_date", :as => :show_by_date
  get "/events/show_ticket/:id", to: "events#show_ticket", :as => :show_ticket
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  resources :events, only: [:index, :new, :create, :show]
  # do
  #   get :show_ticket, on: :member
  #   get :deactivate, on: :collection
  # end
end
