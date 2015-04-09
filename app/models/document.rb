class Document < ActiveRecord::Base
  belongs_to :category
  has_one :result, dependent: :destroy

  validates :data, :category, presence: true

  validate :check_data_attirubets

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

  def check_data_attirubets
    data_hash = deserialize_data

    if data_hash
      data_hash.each do |k, v|
        if v.blank?
          errors.add(k, "can't be blank")
        else
          true
          #check type byy Field.find
        end
      end
    else
      errors.add(:data_attributes, 'something wrong with provided data')
    end
  end

  def create_result!
    self.create_result(category_id: category_id, points: calculate_points)
  end

  def calculate_points
    Rule.calculate_for!(self)
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
