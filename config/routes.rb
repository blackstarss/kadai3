Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }

  root to: 'homes#top'
  get '/home/about' => "homes#about", as: 'about'
  
  delete 'books/:id' => 'books#destroy', as: 'destroy'
  
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
 
  resources :books do
    resource :favorites , only: [:create , :destroy]
    resources :book_comments, only: [:create , :destroy]
  end

end
