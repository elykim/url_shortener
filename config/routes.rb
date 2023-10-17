Rails.application.routes.draw do
  devise_for :users
  root 'urls#index'

  get ':short_url', to: 'urls#redirect', as: :redirect

  resources :urls, only: [:create]
  get 'urls/new', to: 'urls#new', as: :new_url

  get 'cleanup_expired', to: 'urls#cleanup_expired', as: :cleanup_expired

  get 'urls/:id/stats', to: 'urls#stats', as: :url_stats


end
