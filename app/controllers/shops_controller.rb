class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :correct_user, only: [:edit, :destroy]

  # GET /shops
  # GET /shops.json
  def index

    # search query
    if params[:q].nil?
      @shops = Shop.all
    else
      @shops = Shop.search_with_elasticsearch(params[:q]).records
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

  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    # friendly id
    @shop = Shop.friendly.find(params[:id])

    @shopProducts = Product.where(shop_id: @shop.id)
  end

  # GET /shops/new
  def new
    @shop = Shop.new
    @categories = Category.all
  end

  # GET /shops/1/edit
  def edit
    @categories = Category.all
  end

  # POST /shops
  # POST /shops.json
  def create
    @categories = Category.all

    if current_user
      @shop = current_user.shops.build(shop_params)
      # @shop = Shop.new(shop_params)
      respond_to do |format|
        if @shop.save
          format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
          format.json { render :show, status: :created, location: @shop }
        else
          format.html { render :new }
          format.json { render json: @shop.errors, status: :unprocessable_entity }
        end
      end

    else
  		redirect_to new_user_session_path
    end

  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    @categories = Category.all

    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(
        :category_id, :user_id, :title, :image, :description, :location, :email, :phone, :phone_2, :contacts,
        products_attributes: [:shop_id, :image, :name, :price, :description]
      )
    end

    def correct_user
      @targetShop = current_user.shops.friendly.find(params[:id])
      if @targetShop.nil?
        redirect_back(fallback_location: root_path)
        flash[:alert] = 'You dont have an acess to this page'
      end
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
