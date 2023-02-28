class WeathersController < ApplicationController
  before_action :set_weather, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /weathers or /weathers.json
  def index
    @weathers = Weather.all
  end

  # GET /weathers/1 or /weathers/1.json
  def show
  end
  
  # GET /weathers/new
  def new
    @weather = Weather.new
  end

  # GET /weathers/1/edit
  def edit
  end
  
  # GET /search_weather
  def fromApi 
    p "weather params"
    p weather_from_api_params
    
    respond_to do |format|
      format.html { render :search, status: :ok }
    end
  end
  
  # POST /search_weather
  def searchApi
    p "weather api params"
    p weather_search_api_params
    # obtain api call result
    weatherresult = Weather.search(weather_search_api_params["city"])
    p "weather result"
    p weatherresult[:status]

    # verify if result was ok
    if weatherresult[:status] == 200
      # obtain result body
      weatherbody = JSON.parse weatherresult[:body]
      p "weather body"
      p weatherbody
      # capture possible retrieving data errors 
      begin 
        # obtain required weather values and encode them as query url
        city = CGI.escape "Location: #{weatherbody["location"]["name"]}, Region: #{weatherbody["location"]["region"]}"
        degrees = CGI.escape "#{weatherbody["current"]["temp_c"]} °C"
        description = CGI.escape "#{weatherbody["current"]["condition"]["text"]}, at #{weatherbody["current"]["last_updated"]}"
        notice = "Search results found successfully"
        query = "city=#{city}&weather=#{degrees}&description=#{description}"
      rescue => error
        notice = error.message
        query = "error=true"
      end
    else
      # define message and query value when there is an error 
      notice = "Search error"
      query = "error=true"
    end
    
    p "notice"
    p notice

    # return response
    respond_to do |format|
      format.html { redirect_to "#{search_weather_path}?#{query}", notice: notice }
      format.json { render json: weather_api_params, status: :ok }
    end
  end

  # POST /weathers or /weathers.json
  def create
    @weather = Weather.new(weather_params)
    
    respond_to do |format|
      if @weather.save
        format.html { redirect_to weather_url(@weather), notice: "Weather was successfully created." }
        format.json { render :show, status: :created, location: @weather }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weathers/1 or /weathers/1.json
  def update
    respond_to do |format|
      if @weather.update(weather_params)
        format.html { redirect_to weather_url(@weather), notice: "Weather was successfully updated." }
        format.json { render :show, status: :ok, location: @weather }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weathers/1 or /weathers/1.json
  def destroy
    @weather.destroy

    respond_to do |format|
      format.html { redirect_to weathers_url, notice: "Weather was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather
      @weather = Weather.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weather_params
      params.require(:weather).permit(:city, :weather, :description)
    end
    
    def weather_from_api_params
      params.permit(:city, :weather, :description, :error, :authenticity_token, :commit)
    end
    
    def weather_search_api_params
      params.permit(:city, :authenticity_token, :commit)
    end
end
