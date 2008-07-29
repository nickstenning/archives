class String
  # String#lines is only present in ruby >= 1.8.7
  unless "".respond_to? :lines
    alias_method :lines, :to_a
  end
end