Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


  resources :towns, only: [:show, :update] do
    post 'end_construction', on: :member
    post 'end_research', on: :member
    post 'end_defense', on: :member
    patch :update_resources, on: :member
    patch :update_energy, on: :member
    resources :units, only: [:index, :update, :create] do
      post 'upgrade', on: :collection
      get ':role', to: 'units#role_index', constraints: { role: /#{Unit.roles.join('|')}/ }, as: :role_index, on: :collection
      collection do
        get :cost
      end
    end
    resources :battles, only: [:new, :create]
  end

  get "users/:users_username/profile" => "users#show", as: :user_profile

  get "towns/:town_id/structures" => "structure_builts#index", as: :towns_structures
  patch "towns/:town_id/structures/:id" => "structure_builts#update", as: :towns_structure_update

  get "towns/:town_id/researches" => "research_levels#index", as: :towns_researches
  patch "towns/:town_id/researches/:id" => "research_levels#update", as: :towns_research_update

  get "towns/:town_id/defenses" => "defense_builts#index", as: :towns_defenses
  patch "towns/:town_id/defenses/:id" => "defense_builts#update", as: :towns_defense_update

  get 'units/upgrade_cost', to: 'units#upgrade_cost'

  resources :battles, only: [:show]
end
