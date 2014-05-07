Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/projects', to: 'tracker_search#index'

end
