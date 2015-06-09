class Document < ActiveRecord::Base
  belongs_to :category
  has_one :result, dependent: :destroy

  validates :data, :category, presence: true

  validate :check_data_attributes

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

  def check_data_attributes
    data_hash = deserialize_data

    if data_hash
      data_hash.each do |k, v|
        if v.blank?
          errors.add(k, "can't be blank")
        else
          check_consistancy_between_field_type_and_its_value(k, v)
        end
      end
    else
      errors.add(:data, 'something wrong with provided data')
    end
  end

  def create_result!
    self.create_result(category_id: category_id, points: calculate_points)
  end

  def calculate_points
    Rule.calculate_for!(self)
  end

  def check_consistancy_between_field_type_and_its_value(name, value)
    field = Field.find_by(name: name)

    if field
      case field.field_type
      when 'Integer'
        unless value =~ /\A-?\d+\z/
          errors.add(name, 'should be a number')
        end
      when 'Boolean'
        unless value.in?(%w(true false))
          errors.add(name, 'could be only "true" or "false"')
        end
      end
    else
      errors.add(name, 'something is wrong with fields provided')
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
