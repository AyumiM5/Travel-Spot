Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'
  devise_for :users
  
  get 'notes/search' => "searchs#search", as: 'notes_search'
  
  get 'mypage' => 'users#mypage', as: 'mypage'
  patch 'withdraw' => 'users#withdraw'
  get 'mypage/edit' => 'users#edit'
  patch 'mypage/update' => 'users#update'
  
  resources :users, only: [:show], param: :name do
    resource :relationship, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  put "new/:id/post" => "notes#post", as: 'notes_post'
  get "favorite-notes" => "users#favorite", as: "favorite_notes"
  
  resources :notes do
    resources :note_comments, only: [:create, :new, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :spots, only: [:new, :create, :destroy]
  end
  
end
