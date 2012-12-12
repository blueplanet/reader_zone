ReaderZone::Application.routes.draw do
  resources :books, only: [:index, :show, :new, :create, :edit, :update] do
    resources :notes, only: [:new, :create, :edit, :update, :destroy]

    member do
      get 'my', as: 'my_notes'
    end
  end

  root to: "books#index"

  # OnniAuth
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", as: :logout
end
