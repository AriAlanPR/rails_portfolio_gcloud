Rails.application.routes.draw do
  resources :presentations
  get 'welcome/index'
  get 'presentations/html/example', to: "presentations#example"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
