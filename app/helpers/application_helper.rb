# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def icon( name )
    image_tag "/images/icons/#{name}.png", :size => "16x16", :class => "icon"
  end
  
  def show_sidebar?
    # TODO: is there a nice way to do this without rendering the partial?
    begin
      render(:partial => "#{controller.controller_name}/sidebar")
    rescue ActionView::MissingTemplate
      return false
    end
    
    return true
  end
  
  def yield_authenticity_token
    if protect_against_forgery?
      <<JAVASCRIPT
<script type='text/javascript'>
//<![CDATA[
  window._auth_token_name = "#{request_forgery_protection_token}";
  window._auth_token = "#{form_authenticity_token}";
//]]>
</script>
JAVASCRIPT
    end
  end
  
  def autocompleter( objtype )
    { :data => {
        :objtype => objtype.pluralize,
        :url => send("formatted_#{objtype.pluralize}_path", {:format => 'json'})
      }.to_json
    }
  end
  
  def application_javascripts
    vendor = %w[form metadata livequery autocomplete json]
    local  = %[application]
    vendor.map { |x| "vendor/jquery.#{x}" } << local
  end
  
  def nav_link( link_text, path, options={} )
    r = ActionController::Routing::Routes
    
    current_path = r.recognize_path(request.request_uri, {:method => :get})
    named_path   = r.recognize_path(path, {:method => :get})
    
    if (current_path[:controller] == named_path[:controller]) and
       ((options[:specificity] != :action) or (current_path[:action] == named_path[:action]))
      options[:class] ||= ''
      options[:class] += ' active'
    end
    
    link_to link_text, path, options
  end
  
  def sub_nav_link( link_text, path, options )
    nav_link(link_text, path, options.update(:specificity => :action))
  end
  
end
