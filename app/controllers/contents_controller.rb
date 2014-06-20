class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy, :bookmark]
  before_action :set_type
  before_action :verify_login

  # GET /contents
  # GET /contents.json
  def index
    #@contents = Content.all
      @contents = type_class.all
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
    @visuals = Visual.where.not(id: @content.utilizations.ids)
  end

  # GET /contents/new
  def new
    @content = type_class.new
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  # POST /contents.json
  def create
    @content = Content.new(content_params)
    respond_to do |format|
      if @content.save
        format.html { redirect_to @content, notice: "#{type} was successfully created." }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to @content, notice: "#{type} was successfully created." }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to contents_url, notice: 'Content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Upload the video to the VideoServer
  def uploadToServer
    require 'net/http'
    require 'uri'
    uri = URI.parse('http://10.170.138.22:8000/videos/upload')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.path, {'Content-Type' => 'video/*'})
    request.body = params[:video].read
    response = http.request(request)
    redirect_to contents_url, notice: 'Content was successfully uploaded to the server.'+response.body
  end


  def setPlaylist

    require 'json'
    require 'open-uri'

    vid = params[:vidurl]

    #hash = JSON.parse(File.read("/home/dextract/playlist.json"))
    hash = JSON.parse(open("http://10.170.138.22:8000/playlists/di").read)

    last_id = hash["playlist"].last["id"].to_i

   # File.open("/home/dextract/playlist_new.json", "w") do |f|
      vid.each_line do |line|
        line.delete!("\n")
        vidid = line.split("|").first
        video = Video.find_by url: vidid
        itemToAdd = {"id" => last_id+1, "tipo" => "video", "conteudo" => {"id" => video.url, "nome" => video.description}}
        playlistToAdd = {"id" => (last_id+1).to_s}
        hash["items"] << itemToAdd
        hash["playlist"] << playlistToAdd
        last_id = last_id + 1
      end
    #  f.write(JSON.pretty_generate(hash))
    #end

    uri = URI.parse('http://10.170.138.22:8000/playlists/di')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = JSON.pretty_generate(hash)
    response = http.request(request)

    flash[:notice] = response.message
    render :js => 'window.location.reload()'
  end

  def bookmark
    typeAction = params[:typeAction]
    if typeAction == "bookmark"
      current_user.bookmarked << @content
      redirect_to :back, notice: "You bookmarked #{@content.description}"

    elsif typeAction == "unbookmark"
      current_user.bookmarked.delete(@content)
      redirect_to :back, notice: "You unbookmarked #{@content.description}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = type_class.find(params[:id])
    end

    def set_type
      @type = type
    end

    def type
      params[:type] || 'Content'
    end

    def type_class
      type.constantize
    end

    def verify_login
      redirect_to root_path, notice: "Please sign in." unless signed_in?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(type.underscore.to_sym).permit(:name, :description, :organization, :type,
                                                    :user_id, :time, :visualType, :beginDate, :endDate, :local)
    end
end
