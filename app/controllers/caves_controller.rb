class CavesController < InheritedResources::Base

  before_action :set_cafe, only: [:show, :edit, :update, :destroy]
  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:owner, :new, :edit, :create, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]

  def mycafes
    @caves = Cafe.where(user: current_user).order("created_at DESC")
  end

  # GET /caves
  # GET /caves.json
  def index
    @caves = Cafe.all
  end

  # GET /caves/1
  # GET /caves/1.json
  def show
  end

  # GET /caves/new
  def new
    @cafe = Cafe.new
  end

  # GET /caves/1/edit
  def edit
  end

  # POST /caves
  # POST /caves.json
  def create
    @cafe = Cafe.new(cafe_params)
    @cafe.user = current_user

    if current_user.recipient.blank?
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = params[:stripeToken]

      recipient = Stripe::Recipient.create(
        :name => current_user.name,
        :type => "individual",
        :bank_account => token
        )
      end
      current_user.recipient = recipient.id
      current_user.save

    respond_to do |format|
      if @cafe.save
        format.html { redirect_to @cafe, notice: 'Cafe was successfully created.' }
        format.json { render :show, status: :created, location: @cafe }
      else
        format.html { render :new }
        format.json { render json: @cafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caves/1
  # PATCH/PUT /caves/1.json
  def update
    respond_to do |format|
      if @cafe.update(cafe_params)
        format.html { redirect_to @cafe, notice: 'Cafe was successfully updated.' }
        format.json { render :show, status: :ok, location: @cafe }
      else
        format.html { render :edit }
        format.json { render json: @cafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caves/1
  # DELETE /caves/1.json
  def destroy
    @cafe.destroy
    respond_to do |format|
      format.html { redirect_to caves_url, notice: 'Cafe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



private

  # Use callbacks to share common setup or constraints between actions.
  def set_cafe
    @cafe = Cafe.find(params[:id])
  end

  def cafe_params
    params.require(:cafe).permit(:user_id, :name, :description, :address, :city, :state, :zipcode, :image)
  end

  def check_user
    if current_user != @cafe.user
      respond_to do |format|
        format.html { redirect_to @cafe, alert: 'Sorry, only the cafe owner has access to this.' }
        format.json { head :no_content }
      end
    end
  end

end
