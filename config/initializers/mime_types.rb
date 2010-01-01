# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

# Avoid nasty 'already initialized constant' warnings
unless Mime.const_defined?('PDF')
  Mime::Type.register "application/pdf", :pdf
end