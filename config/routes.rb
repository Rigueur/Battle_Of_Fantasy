Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


  resources :homebases, only: [:show]

  get "homebases/:id" => "homebases#show", as: :homebase
  patch "homebases/:id" => "homebases#update", as: :homebase_update

  get "homebases/:homebases_id/structures" => "structure_builts#index", as: :homebases_structures
  patch "homebases/:homebases_id/structures/:id" => "structure_builts#update", as: :homebases_structure_update

  get "homebases/:homebases_id/researches" => "research_levels#index", as: :homebases_researches
  patch "homebases/:homebases_id/researches/:id" => "research_levels#update", as: :homebases_research_update

  get "homebases/:homebases_id/defenses" => "defense_builts#index", as: :homebases_defenses
  patch "homebases/:homebases_id/defenses/:id" => "defense_builts#update", as: :homebases_defense_update

end
