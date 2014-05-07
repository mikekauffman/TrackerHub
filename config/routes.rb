Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/projects', to: 'projects#index'
  get '/projects/:id', to: 'projects#show', as: :project

end
