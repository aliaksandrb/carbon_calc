class ResultsController < ApplicationController
  def index
    category_id = params[:category_id]
    chart_data = { labels: [], data: [] }

    results = if !category_id.blank? && category_id.to_i != 0
      chart_data[:label] = category_name_by_id(category_id)
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

  def insides
    chart_data = Result.all.group_by(&:category_id).map do |category_id, results|
      {
        label: category_name_by_id(category_id),
        value: results.inject(0) { |sum, r| sum + r.points }
      }
    end

    respond_to do |format|
      format.json { render json: chart_data, status: :ok }
    end
  end

  private

  def category_name_by_id(id)
    Category.find(id).name
  end

end
