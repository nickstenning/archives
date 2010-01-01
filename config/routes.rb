ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.edit_item 'items/:id/edit/:stage', :controller => 'items', :action => 'edit', :stage => ''
  map.resources :items do |item|
    item.resources :attachments
  end
  
  map.resources :shows  
  map.resources :people
  map.resources :attachments
  map.resources :organisations
  
  map.with_options :controller => 'session' do |session|
    session.login 'session/login', :action => 'login'
    session.new_session 'session/new', :action => 'new'
    session.create_session 'session/create', :action => 'create'
    session.destroy_session 'session/destroy', :action => 'destroy'
  end

  map.root :controller => 'home'
end
