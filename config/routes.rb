ReaderZone::Application.routes.draw do
  resources :books, only: [:index, :show]

  root to: "books#index"

  # OnniAuth
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", as: :logout
end
