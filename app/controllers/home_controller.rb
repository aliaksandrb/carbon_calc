class HomeController < ApplicationController
  def index
    category_id = params[:category_id]

    @documents = if !category_id.blank? && category_id.to_i != 0
      Document.where(category_id: category_id).order(created_at: :desc)
    else
      Document.all.order(created_at: :desc)
    end

    @categories = Category.all
  end
end
