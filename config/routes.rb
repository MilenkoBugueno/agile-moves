AgileMovesOs::Application.routes.draw do
  resources :tomatoes


  resources :states


  resources :ratings


  resources :move_types


  resources :moves do
    resources :ratings
    resources :tomatoes do
      collection do
        put :move
      end
    end
    collection do
      put :move
    end
  end


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end