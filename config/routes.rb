InnovationsqCom::Application.routes.draw do
  match '/:handle' => 'profiles#show'
  root :to => 'welcome#index'
end
