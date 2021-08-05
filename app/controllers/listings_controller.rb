class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :authorize_user!, only: %i[ edit update destroy ]
  skip_before_action :verify_authenticity_token, only: %i[ strip_session ]

  def index
    @listing = Listing.all #.search(params[:query], params[:option])#.includes(:car)
  end

  def show
  end

  def new
    @listing = Listing.new
    # @car = @listing.cars.build
  end

  def edit
  end

  def create
    @listing = current_user.listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.require(:listing).permit(:user_id, :variant_id, :colour_id, :title, :price, :mileage, :description, :state_id, :sold, :make_id, :model_id, :engine_id, :transmission_id, :fuel_id, :body_type_id, :drive_type_id, :door_id, :speed_id, :image, feature_ids: [])
  end

  def authorize_user!
    if current_user.id != @listing.user.id
      flash[:alert] = "Unauthorized Request!"
      redirect_to @listing
    end
  end

  def set_form_vars
    @features = Features.all
  end
end
