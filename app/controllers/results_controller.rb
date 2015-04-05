class ResultsController < ApplicationController
  def index
    chart_data = Result.chart_data_general(params[:category_id])

    respond_to do |format|
      format.json { render json: chart_data, status: :ok }
    end
  end

  def insides
    chart_data = Result.chart_data_for_insides

    respond_to do |format|
      format.json { render json: chart_data, status: :ok }
    end
  end

  def insides_historical
    chart_data = Result.chart_data_for_insides_historical

    respond_to do |format|
      format.json { render json: chart_data, status: :ok }
    end
  end
end
