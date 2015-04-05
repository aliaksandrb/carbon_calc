class Result < ActiveRecord::Base
  belongs_to :document

  def self.chart_data_general(category_id)
    chart_data = { labels: [], data: [] }

    results = if !category_id.blank? && category_id.to_i != 0
      chart_data[:label] = Category.category_name_by_id(category_id)
      where(category_id: category_id)
    else
      chart_data[:label] = 'General Overview'
      all
    end

    results.each do |result|
      chart_data[:labels] << result.created_at.strftime('%d:%m:%y')
      chart_data[:data]   << result.points
    end

    chart_data
  end

  def self.chart_data_for_insides
    all.group_by(&:category_id).map do |category_id, results|
      {
        label: Category.category_name_by_id(category_id),
        value: results.inject(0) { |sum, r| sum + r.points }
      }
    end
  end
end

# == Schema Information
#
# Table name: results
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  points      :integer          default(0)
#  document_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_results_on_category_id  (category_id)
#
