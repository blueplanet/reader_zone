ReaderZone::Application.routes.draw do
  resources :books, only: [:index]

end
