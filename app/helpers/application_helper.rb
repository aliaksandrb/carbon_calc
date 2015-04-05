module ApplicationHelper
  def category_name(id)
    Category.find(id).name
  end
end
