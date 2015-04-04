class Document < ActiveRecord::Base
  belongs_to :category

  def fields
    category ? category.fields : []
  end

  def deserialize_data
    data ? JSON.parse(data) : nil
  end

  def method_missing(method_sym, *arguments, &block)
    data_hash = deserialize_data

    if data_hash
      data_hash[method_sym.to_s]
    else
      super
    end
  end
end

# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  data        :text             not null
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_documents_on_category_id  (category_id)
#
