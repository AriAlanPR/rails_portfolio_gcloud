Rails.application.routes.draw do
  resources :weathers
  resources :presentations
  get 'welcome/index'
  get 'presentations/html/example', to: "presentations#example"
  get 'search_weather', to: "weathers#fromApi"
  post 'search_weather', to: "weathers#searchApi"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
