class Api::V1::ServicesController < ApplicationController
  before_action :set_service, only: %i[ show update destroy ]

  # GET /services
  def index
    @services = Service.all

    render json: @services, include: [:category]
  end

  # GET /services/1
  def show
    render json: @service, include: [:category]
  end

  # POST /services
  def create
    @service = Service.new(service_params)

    if @service.save
      render json: @service, include: [:category], status: :created, location: api_v1_category_url(@service)
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /services/1
  def update
    if @service.update(service_params)
      render json: @service, include: [:category]
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_params
      params.require(:service).permit(:description, :service_type, :category_id)
    end
end
