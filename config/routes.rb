InnovationsqCom::Application.routes.draw do
  
  scope ":handle" do
    resources :docs
    match 'pitch-deck' => "profiles#pitch_deck"
  end
  
  match '/:handle' => 'profiles#show'
  root :to => 'welcome#index'
end
