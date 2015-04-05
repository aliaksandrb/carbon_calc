class Document < ActiveRecord::Base
  belongs_to :category
  has_one :result, dependent: :destroy

  validates :data, :category, presence: true

  after_save :create_result!

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

  protected

  def create_result!
    self.create_result(category_id: category_id, points: calculate_points)
  end

  def calculate_points
    rules = Rule.where(category_id: category_id)
    points = 0
    data_hash = deserialize_data

    rules.each do |rule|
      raw_value = data_hash[rule.field_name]

      if raw_value
        if eval("#{raw_value} #{rule.operation} #{rule.comparative}")
          points += rule.points
        end
      end
    end

    points
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
