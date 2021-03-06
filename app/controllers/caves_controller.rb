class CavesController < InheritedResources::Base
  #include Comparable

  before_action :set_cafe, only: [:show, :edit, :update, :destroy]
  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:owner, :new, :edit, :create, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]
  before_filter :check_admin, only: [:new]
  # before_action :flag_newUser

  #capacity
  helper_method :totalCurrentSessions
   def totalCurrentSessions
     @sessions = Session.where(cafe_id: @cafe.id)
     @currentTime = Time.now.in_time_zone("Pacific Time (US & Canada)")
     @total = 0
     @sessions.each do |s|
       if (s.start..s.finish).cover?(@currentTime)
         @total+=1
       end
    end
     @cafe.capacity - @total
  end
  ###


  def mycafes
    @caves = Cafe.where(user: current_user).order("created_at DESC")
  end

  # GET /caves
  # GET /caves.json
  def index
    @caves = Cafe.all
    # respond_to do |format|
    #   if current_user.email != 'rforgeon@gmail.com'
    #     #nothing
    #     format.html
    #     format.json
    #   else
    #     format.html { redirect_to root_path, notice: 'Stop by an hourly CoWorking location - as low as $4/hour!' }
    #     format.json { head :no_content }
    #   end
    # end

    # respond_to do |format|
    #   format.html
    #   format.json
    #   format.js
    #end
  end

  # GET /caves/1
  # GET /caves/1.json
  def show
    @images = Image.where(cafe_id: @cafe.id)
    #avg_rating
    @reviews = Review.where(cafe_id: @cafe.id).order('created_at DESC')
    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
    end

    @sessions = Session.where(cafe_id: @cafe.id)

    respond_to do |format|
      format.html
      format.json
    end
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
    @userfullname = "#{current_user.name} #{current_user.last_name}"

    if current_user.recipient.blank?
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = params[:stripeToken]

      recipient = Stripe::Recipient.create(
        :name => @userfullname,
        :type => "individual",
        :bank_account => token
        )
      end
      current_user.recipient = recipient.id
      current_user.save

    respond_to do |format|
      if @cafe.save
        format.html { redirect_to @cafe, notice: 'Space was successfully created.' }
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
        format.html { redirect_to @cafe, notice: 'Space was successfully updated.' }
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
      format.html { redirect_to caves_url, notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



private

  # Use callbacks to share common setup or constraints between actions.
  def set_cafe
    @cafe = Cafe.find(params[:id])
  end

  def cafe_params
    params.require(:cafe).permit(:user_id, :name, :description, :address, :city, :state, :zipcode, :image, :checkin, :capacity, :phone, :rate)
  end

  def check_user
    if current_user != @cafe.user
      respond_to do |format|
        format.html { redirect_to @cafe, alert: 'Sorry, only the cafe owner has access to this.' }
        format.json { head :no_content }
      end
    end
  end

  def check_admin
    if current_user.email != 'rforgeon@gmail.com'
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Please contact us if you would like to list your space!' }
        format.json { head :no_content }
        end
      end
    end

    # def flag_newUser
    #   #unless current_user.subscribed
    #     flash[:notice] = "Stop in for Hourly CoWorking as low as $4/hour!"
    #   #end
    # end

  end
