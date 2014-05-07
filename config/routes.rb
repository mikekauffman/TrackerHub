Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/projects', to: 'tracker_search#index'
  get '/projects/:id', to: 'tracker_search#show', as: :project

end
