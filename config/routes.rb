Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'
  
  devise_for :users
  
  get 'mypage' => 'users#show'
  patch 'withdraw' => 'users#withdraw'
  get 'mypage/edit' => 'users#edit'
  patch 'mypage/update' => 'users#update'
  
  resources :notes
  
end
