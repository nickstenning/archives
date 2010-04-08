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
  
  def nonblank(text, fallback)
    if text and text.strip.any?
      text
    else
      fallback
    end
  end
end
