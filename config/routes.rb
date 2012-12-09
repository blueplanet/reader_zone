ReaderZone::Application.routes.draw do
  get "notes/new"

  resources :books, only: [:index, :show] do
    resources :notes, only: [:new, :create]

    member do
      get 'my', as: 'my_notes'
    end
  end

  root to: "books#index"

  # OnniAuth
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", as: :logout
end
