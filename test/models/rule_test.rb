require 'test_helper'

class RuleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: rules
#
#  id          :integer          not null, primary key
#  field_type  :string           default("Integer")
#  field_name  :string           not null
#  operation   :string           not null
#  comparative :string           not null
#  points      :integer          default(0)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_rules_on_category_id  (category_id)
#
