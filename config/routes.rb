Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tournaments#index'

  resources :tournaments      , only: [:index, :show, :new, :create]
  resources :rounds           , only: [:index, :show, :update]
  resources :playoffs         , only: [:show, :update]
  resources :clubs            , only: [:index]
  resources :hole_stats       , only: [:index]
  resources :leaders_snapshots, only: [:index, :show]

  resource :player_club_stat_suites, only: [:show] do
    get :remember_player, :forget_player
  end

  get 'player_clubs/alter'
  get 'player_clubs/restore'

  resource :cut_off, only: %i[show update] do
    member do
      get :confirm_update
    end
  end

  resources :db_backups, only: [:index, :create]
end
