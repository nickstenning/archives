module ItemsHelper
  def attachment_collection_select(f)
    f.collection_select :attachments, Attachment.unattached, :id, :doc_id, {}, {:multiple => true,:name => 'item[attachment_ids][]'}
  end
end
