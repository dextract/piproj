class VisualUtilizationsController < ApplicationController
  before_action :set_visual_utilization, only: [:show, :edit, :update, :destroy]

  # GET /visual_utilizations
  # GET /visual_utilizations.json
  def index
    @visual_utilizations = VisualUtilization.all
  end

  # GET /visual_utilizations/1
  # GET /visual_utilizations/1.json
  def show
  end

  # GET /visual_utilizations/new
  def new
    @visual_utilization = VisualUtilization.new
  end

  # GET /visual_utilizations/1/edit
  def edit
  end

  # POST /visual_utilizations
  # POST /visual_utilizations.json
  def create
    @visual_utilization = VisualUtilization.new(visual_utilization_params)

    respond_to do |format|
      if @visual_utilization.save
        format.html { redirect_to @visual_utilization, notice: 'Visual utilization was successfully created.' }
        format.json { render :show, status: :created, location: @visual_utilization }
      else
        format.html { render :new }
        format.json { render json: @visual_utilization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visual_utilizations/1
  # PATCH/PUT /visual_utilizations/1.json
  def update
    respond_to do |format|
      if @visual_utilization.update(visual_utilization_params)
        format.html { redirect_to @visual_utilization, notice: 'Visual utilization was successfully updated.' }
        format.json { render :show, status: :ok, location: @visual_utilization }
      else
        format.html { render :edit }
        format.json { render json: @visual_utilization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visual_utilizations/1
  # DELETE /visual_utilizations/1.json
  def destroy
    @visual_utilization.destroy
    respond_to do |format|
      format.html { redirect_to visual_utilizations_url, notice: 'Visual utilization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visual_utilization
      @visual_utilization = VisualUtilization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visual_utilization_params
      params.require(:visual_utilization).permit(:content_id, :visual_id)
    end
end
