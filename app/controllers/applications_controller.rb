class ApplicationsController < ApplicationController
  def index
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.create(application_params)
    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:applicant_name, :applicant_street_address, :applicant_city, :applicant_state, :applicant_zip_code, :description, :status)
  end
end
