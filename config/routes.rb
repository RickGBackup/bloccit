Rails.application.routes.draw do

  resources :labels, only: [:show]

  resources :questions
  resources :advertisements
  
  resources :topics do     #nest the :posts and :sponsored_posts resources inside :topics
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index, :update, :destroy ] #only new, edit and view controller actions.
    resources :comments, only: [:create, :destroy]
  end
  
  resources :posts, only: [] do  #shallow routing -  creates posts/:post_id/comments routes, without deep nesting under topics.
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:new, :create]
  
  resources :sessions, only: [:new, :create, :destroy]
  
  post 'users/confirm' => 'users#confirm'
  
  get 'about' => 'welcome#about'
  
  get 'welcome/contact'
  
  get 'welcome/faq'

  root 'welcome#index'
end
