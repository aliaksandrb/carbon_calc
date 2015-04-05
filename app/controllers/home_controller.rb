class HomeController < ApplicationController
  def index
    category_id = params[:category_id]

    @documents = if !category_id.blank? && category_id.to_i != 0
      @category_name = Category.find(category_id).name
      Document.where(category_id: category_id).order(created_at: :desc)
    else
      @category_name = 'General Overview'
      Document.all.order(created_at: :desc)
    end

    @categories = Category.all
  end
end
