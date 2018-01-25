Rails.application.routes.draw do

  resources :questions
  resources :advertisements
  
  resources :topics do     #nest the :posts and :sponsored_posts resources inside :topics
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index, :update, :create, :destroy ] #only new, edit and view controller actions.
  end
  
  get 'about' => 'welcome#about'
  
  get 'welcome/contact'
  
  get 'welcome/faq'

  root 'welcome#index'
end
