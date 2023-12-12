Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


  resources :towns, only: [:show, :update] do
    resources :units, only: [:index, :update, :create]
  end

  resources :users, only: [:show]

  get "towns/:towns_id/structures" => "structure_builts#index", as: :towns_structures
  patch "towns/:towns_id/structures/:id" => "structure_builts#update", as: :towns_structure_update

  get "towns/:towns_id/researches" => "research_levels#index", as: :towns_researches
  patch "towns/:towns_id/researches/:id" => "research_levels#update", as: :towns_research_update

  get "towns/:towns_id/defenses" => "defense_builts#index", as: :towns_defenses
  patch "towns/:towns_id/defenses/:id" => "defense_builts#update", as: :towns_defense_update
end
