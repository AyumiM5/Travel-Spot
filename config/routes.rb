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
    resources :schedules, only: [:new, :create, :destroy] do
      resources :spots, only: [:create, :destroy]
    end
  end
  
end
