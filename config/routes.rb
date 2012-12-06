ReaderZone::Application.routes.draw do
  get "notes/new"

  resources :books, only: [:index, :show] do
    resources :notes, only: [:new, :create]
  end

  root to: "books#index"

  # OnniAuth
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", as: :logout
end
