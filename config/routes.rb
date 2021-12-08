Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#new_guest'
  end

  get 'search' => "searchs#search", as: 'search'
  get 'search/tag/:tag_name' => "searchs#tag_search", as: 'tag_search'

  get 'mypage' => 'users#mypage', as: 'mypage'
  patch 'withdraw' => 'users#withdraw'
  get 'mypage/edit' => 'users#edit'
  patch 'mypage/update' => 'users#update'

  resources :users, only: [:show], param: :name do
    resource :relationship, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  put 'new/:id/post' => 'notes#post', as: 'notes_post'
  get 'favorite-notes' => 'users#favorite', as: 'favorite_notes'

  get 'notes/draft' => 'notes#draft', as: 'notes_draft'

  resources :notes do
    resources :note_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :spots, only: [:new, :create, :destroy]
  end

  resources :notifications, only: :index
end
