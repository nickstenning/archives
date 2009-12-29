module ItemsHelper
  def attachment_collection_select(f)
    f.collection_select :attachments, Attachment.unattached, :id, :url, {}, {:multiple => true,:name => 'item[attachment_ids][]'}
  end
end
