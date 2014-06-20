class VisualsController < ApplicationController
  before_action :set_visual, only: [:show, :edit, :update, :destroy, :associate]
  before_action :set_type
  before_action :verify_login

  # GET /visuals
  # GET /visuals.json
  def index
    @visuals = type_class.all
  end

  # GET /visuals/1
  # GET /visuals/1.json
  def show
  end

  # GET /visuals/new
  def new
    @visual = type_class.new
  end

  # GET /visuals/1/edit
  def edit
  end

  # POST /visuals
  # POST /visuals.json
  def create
    @visual = Visual.new(visual_params)

    respond_to do |format|
      if @visual.save
        format.html { redirect_to @visual, notice: 'Visual was successfully created.' }
        format.json { render :show, status: :created, location: @visual }
      else
        format.html { render :new }
        format.json { render json: @visual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visuals/1
  # PATCH/PUT /visuals/1.json
  def update
    respond_to do |format|
      if @visual.update(visual_params)
        format.html { redirect_to @visual, notice: 'Visual was successfully updated.' }
        format.json { render :show, status: :ok, location: @visual }
      else
        format.html { render :edit }
        format.json { render json: @visual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visuals/1
  # DELETE /visuals/1.json
  def destroy
    @visual.destroy
    respond_to do |format|
      format.html { redirect_to visuals_url, notice: 'Visual was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def associate
    typeAction = params[:typeAction]
    content = Content.find(params[:content])
    if typeAction == "associate"
      content.utilizations << @visual
      redirect_to :back, notice: "You associated #{@visual.description}"

    elsif typeAction == "desassociate"
      content.utilizations.delete(@visual)
      redirect_to :back, notice: "You desassociated #{@visual.description}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visual
      @visual = type_class.find(params[:id])
    end

  def set_type
    @type = type
  end

  def type
    params[:type] || 'Visual'
  end

  def type_class
    type.constantize
  end

  def verify_login
    redirect_to root_path, notice: "Please sign in." unless signed_in?
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visual_params
      params.require(type.underscore.to_sym).permit(:type, :youtube_id, :description, :user_id, :image)
    end
end
