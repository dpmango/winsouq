class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show

    # search query
    if params[:q].nil?
      @shops = Shop.where(category_id: params[:id])
    else
      @shops = Shop.search_with_elasticsearch(params[:q]).records.where(category_id: params[:id])
    end

    if params[:filter].present?
      if params[:filter] == 'name'
        @shops = @shops.order('title ASC')
      elsif params[:filter] == 'date'
        @shops = @shops.order('updated_at DESC')
      elsif params[:filter] == 'location'
        define_location
        @shops = @shops.near([@latitude, @longitude], 8_000_000, order: 'distance')
      end
    else
      @shops = @shops.order('updated_at DESC')
    end

    @shops = @shops.page(params[:page]).per(20)


  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :icon, :color)
    end

    def define_location
    	# if have geolocation cookies
    	if !cookies[:geolocation].nil?
    		@location = JSON.parse(cookies[:geolocation]).symbolize_keys
    	else
    		# or detect by ip
    		@ip = request.remote_ip
    		if Rails.env.production?
    			locale = request.location
    			@location = {longitude: locale.longitude, latitude: locale.latitude}
    		else
    			@location = GeoIp.geolocation("192.206.151.131")
    		end
    	end
    	@latitude = @location[:latitude]
    	@longitude = @location[:longitude]
    	cookies[:geolocation] = { value: JSON.generate(@location), expires: Time.now + 3600 * 24 * 7 }
    end

end
