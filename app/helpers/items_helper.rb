module ItemsHelper
  def attachment_collection_select(f)
    f.collection_select :attachments, Attachment.unattached, :id, :doc_id, {}, {:multiple => true,:name => 'item[attachment_ids][]'}
  end
  
  def link_to_doc_viewer(text, item, attachment=nil)
    link_to text,
            attachment ? item_attachment_path(item, attachment) : item_attachments_path(item), 
            :popup => ['doc_viewer', 
                       'menubar=no,toolbar=no,location=no,' +
                       'status=no,width=600,height=700,top=5,left=5']
  end
  
end
