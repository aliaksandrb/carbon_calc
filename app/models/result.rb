class Result < ActiveRecord::Base
  belongs_to :document
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
