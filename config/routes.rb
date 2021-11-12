Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'
  
  devise_for :users
  
  get 'mypage' => 'users#show'
  patch 'withdraw' => 'users#withdraw'
  get 'mypage/edit' => 'users#edit'
  patch 'mypage/update' => 'users#update'
  
  put "new/:id/post" => "notes#post", as: 'notes_post'
  
  resources :notes do
    resources :note_comments, only: [:create, :new, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :spots, only: [:new, :create, :destroy]
  end
  
end
