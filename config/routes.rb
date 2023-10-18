Rails.application.routes.draw do
  devise_for :users,
             path: '/',
             path_names: {
               sign_in: 'login',
               sign_up: 'sign_up',
               sign_out: 'logout'
             }
  root to: "urls#index"

  get ':short_url', to: 'urls#redirect', as: :redirect

  resources :urls, param: :slug

  get 'cleanup_expired', to: 'urls#cleanup_expired', as: :cleanup_expired

  get 'urls/:id/stats', to: 'urls#stats', as: :url_stats



end
