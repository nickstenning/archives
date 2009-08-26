ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.resources :items
  map.item_form 'items/:id/:stage', :controller => 'items', :action => 'form'
  
  map.resources :shows  
  
  map.login 'session/login', :controller => 'session', :action => 'login'
  map.new_session 'session/new', :controller => 'session', :action => 'new'
  map.create_session 'session/create', :controller => 'session', :action => 'create'
  map.destroy_session 'session/destroy', :controller => 'session', :action => 'destroy'

  map.root :controller => 'home'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
