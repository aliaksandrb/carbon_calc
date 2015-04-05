class ResultsController < ApplicationController
  def index
    category_id = params[:category_id]
    chart_data = { labels: [], data: [] }

    results = if !category_id.blank? && category_id.to_i != 0
      chart_data[:label] = Category.find(category_id).name
      Result.where(category_id: category_id)
    else
      chart_data[:label] = 'General Overview'
      Result.all
    end

    results.each do |result|
      chart_data[:labels] << result.created_at.strftime('%d:%m:%y')
      chart_data[:data]   << result.points
    end

    respond_to do |format|
      format.json { render json: chart_data, status: :ok }
    end
  end
end
