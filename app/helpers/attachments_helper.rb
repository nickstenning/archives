module AttachmentsHelper
  
  def navigator_attrs(leftright, item, attachments, attachment)    
    attrs = { :href => '#' }
    idx = attachments.index(attachment)
    
    raise Exception, "Attachment '#{attachment}' not in list given." unless idx
    
    case leftright
    when :left
      if idx <= 0
        attrs[:class] = 'disabled'
      else
        attrs[:href] = item_attachment_path(item, attachments[idx - 1])
      end
    when :right
      if idx >= attachments.length - 1
        attrs[:class] = 'disabled'
      else
        attrs[:href] = item_attachment_path(item, attachments[idx + 1])
      end
    else
      raise ArgumentError, "leftright should be one of :left or :right!"
    end
    
    return attrs
  end
  
end
