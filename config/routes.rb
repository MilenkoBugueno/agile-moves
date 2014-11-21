AgileMovesOs::Application.routes.draw do

  scope "(:locale)" do                   #To change the url from for example http://localhost:3000/users/edit?locale=en
                                      # to http://localhost:3000/en/users/edit
  resources :projects do
    collection do
      get :work
      get :report
      get :plan
      get :certificate
    end
       end
  resources :inscriptions

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
  end
  
  resources :tomatoes do
    resources :interruptions
    resources :ratings
    collection do
      put :done
      put :move
      put :sendto
      put :markasdone
    end
  end

  resources :comments

  resources :live_tomatoes

  get '/de/live_refresh' => 'live_tomatoes#index'
  get '/en/live_refresh' => 'live_tomatoes#index'

  resources :admin_logs

  resources :certifications

  resources :registrations


  resources :media do
    collection do
      put :sendto
    end
  end


  resources :widgets


  resources :categories

  authenticated :user do
    root :to => 'moves#index'
  end
  root :to => "moves#index"
  devise_for :users
  resources :users
  end
end