Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/projects', to: 'projects#index'
  get '/projects/:id', to: 'projects#show', as: :project
  get '/projects/:id/repo/:owner/:repo_name/sha/:sha_id/comment', to: 'projects#add_comment'
  post '/projects/:id/repo/:owner/:repo_name/sha/:sha_id/comment', to: 'projects#create'

end
