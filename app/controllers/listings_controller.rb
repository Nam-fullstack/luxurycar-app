class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :authorize_user!, only: %i[ edit update destroy ]
  before_action :set_form_vars, only: %i[new edit]
  before_action :set_variant, only: %i[new create]
  # skip_before_action :verify_authenticity_token, only: %i[ strip_session ]

  def index
    @listing = Listing.all#.includes(:user)
    #.search(params[:query], params[:option])#.includes(:car)
  end

  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'], 
      customer_email: current_user&.email, #current_user && current_user.email 
      line_items: [{
        name: @listing.title, 
        description: @listing.description, 
        amount: @listing.price,
        currency: 'aud', 
        quantity: 1
      }], 
      payment_intent_data: {
        metadata: {
          user_id: current_user&.id,
          listing_id: @listing.id
        }
      }, 
      success_url: "#{root_url}/success?title=#{@listing.title}", 
      cancel_url: "#{root_url}/listings"
    )

    @session_id = session.id 
    puts "*********"
    pp @session_id
    puts "*********"
  end

  def new
    @listing = Listing.new
  end

  # Converts the price from cents back to dollars when the form renders.
  def edit
    @listing.price /= 100
  end

  def create
    @listing = current_user.listings.new(listing_params)
    @listing.variant_id = @variant.id
    @listing.title = @variant.name
    puts "THIS IS THE DAMN POSTCODE, WHY ARE YOU SAYING IT'S BLANK #{@listing.postcode} \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
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
    params.require(:listing).permit(:user_id, :variant_id, :colour_id, :title, :price, :mileage, :description, :state_id, :sold, :postcode, pictures: [], feature_ids: [])
  end

  def authorize_user!
    if current_user.id != @listing.user.id
      flash[:error] = "Unauthorized Request!"
      redirect_to listings_path
    end
  end

  def set_form_vars
    @features = Feature.all
  end

  def set_variant
    @variant = Variant.last
  end
end
