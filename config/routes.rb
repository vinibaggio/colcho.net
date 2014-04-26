Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt\-BR/ do
    resources :rooms do
      resources :reviews, only: [:create, :update], module: :rooms
    end
    resources :users

    resource :confirmation, only: [:show]
    resource :user_sessions, only: [:create, :new, :destroy]
  end

  get '/:locale' => 'home#index', locale: /en|pt\-BR/

  root 'home#index'
end
