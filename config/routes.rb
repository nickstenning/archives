ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.edit_item 'items/:id/edit/:stage', :controller => 'items', :action => 'edit'
  map.resources :items
  
  map.resources :shows  
  
  map.login 'session/login', :controller => 'session', :action => 'login'
  map.new_session 'session/new', :controller => 'session', :action => 'new'
  map.create_session 'session/create', :controller => 'session', :action => 'create'
  map.destroy_session 'session/destroy', :controller => 'session', :action => 'destroy'

  map.root :controller => 'home'
end
