class HomeController < ApplicationController
  def index
    category_id = params[:category_id]

    @documents = if !category_id.blank? && category_id.to_i != 0
      @category_name = Category.find(category_id).name
      Document.includes(:result).where(category_id: category_id).order(created_at: :desc).limit(5)
    else
      @category_name = 'General Overview'
      Document.includes(:result).all.order(created_at: :desc).limit(5)
    end

    @categories = Category.all
  end
end
