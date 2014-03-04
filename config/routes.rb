AgileMovesOs::Application.routes.draw do
  resources :projects do
    collection do
      get 'plan'
      get 'work'
      get 'report'
    end
  end

  resources :capacities

  resources :reports do
    collection do
      get 'index'
      get 'tomatoes'
      get 'ideas'
    end  
  end

  resources :interruptions

  resources :states

  resources :ratings

  resources :move_types

  resources :moves do
    resources :ratings
    resources :tomatoes do
      collection do
        put :done
        put :move
      end
    end
    collection do
      put :move
    end
  end
  
  resources :tomatoes do
    resources :interruptions
    collection do
      put :done
      put :move
    end
  end


  authenticated :user do
    root :to => 'projects#index'
  end
  root :to => "projects#index"
  devise_for :users
  resources :users
end