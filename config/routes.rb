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
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote   # POST route at post/:id/up-vote. associated with votes#up_vote action.  as: :up_vote ties it to the up_vote_path method. 
    post '/down-vote' => 'votes#down_vote', as: :down_vote   
  end
  
  resources :users, only: [:new, :create, :show]
  
  resources :sessions, only: [:new, :create, :destroy]
  
  post 'users/confirm' => 'users#confirm'
  
  get 'about' => 'welcome#about'
  
  get 'welcome/contact'
  
  get 'welcome/faq'

  root 'welcome#index'
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
      resources :topics, only: [:index, :show]
    end
  end
end
