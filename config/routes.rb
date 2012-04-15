InnovationsqCom::Application.routes.draw do
  
  scope ":handle" do
    resources :docs
    match 'stream' => "profiles#stream"
    match 'pitch-deck' => "profiles#pitch_deck"
    match 'recommend' => "recommendations#create"
    match 'unrecommend' => "recommendations#destroy"
    match 'follow' => "follow#create"
    match 'unfollow' => "follow#destroy"
  end
  
  match '/:handle' => 'profiles#show'
  root :to => 'welcome#index'
end
