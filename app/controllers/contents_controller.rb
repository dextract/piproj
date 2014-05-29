class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy, :bookmark]
  before_action :set_type

  # GET /contents
  # GET /contents.json
  def index
    #@contents = Content.all
    @contents = type_class.all
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
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
    uri = URI.parse('http://10.22.104.158:8080/videos/upload')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.path, {'Content-Type' => 'video/*'})
    request.body = params[:video].read
    response = http.request(request)
    redirect_to contents_url, notice: 'Content was successfully uploaded to the server.'+response.body
  end

  def setPlaylist

    require 'net/http'
    require 'uri'

    vid = params[:vidurl]

    result = ''

    vid.each_line do |line|
     result = result + line.split[0] + "\n"
    end

    @playlist = Nokogiri::XML(File.open("/home/dextract/playlist.xml")) do |config|
      config.default_xml.noblanks
    end

    last_id = @playlist.xpath("//item[last()]/@id").first.value
    last_item = @playlist.xpath("//list").first

    result.each_line do |line|
      line.delete!("\n")
      last_id = last_id.to_i + 1
      name_node = Nokogiri::XML::Node.new("video",@playlist)
      name_node.set_attribute('id', line)
      data_node = Nokogiri::XML::Node.new("item",@playlist)
      data_node.add_child(name_node)
      data_node.set_attribute('id', last_id)
      data_node.set_attribute('tipo', 'video')
      last_item.add_previous_sibling(data_node)
    end

    file = File.open("/home/dextract/playlist_new.xml", 'w+')
    file.puts @playlist.to_xml(:indent => 2)

    uri = URI.parse('http://10.170.138.22:8000/playlists/update/1')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'text/xml'})
    request.body = @playlist.to_xml(:indent => 2, :encoding => "UTF-8")
    response = http.request(request)

    flash[:notice] = response.message+' '+response.body
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(type.underscore.to_sym).permit(:description, :url, :type, :user_id)
    end
end
