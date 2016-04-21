class SessionsController < InheritedResources::Base

  #before_action :set_order, only [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  helper_method :convert_datetimes_to_pdt
  def convert_datetimes_to_pdt(field)
    field = field + Rational(7,24) #hours in day (UTC is 7 hours ahead of Pacific Time)
  end

  helper_method :subtract_credits
  def subtract_credits
    @cafe = Cafe.find(params[:cafe_id])
    @duration = ((@session.finish - @session.start)/ 1.hour).round(2)
    @userCredit = current_user.credit
    @totalPay = @cafe.rate * @duration

    if @totalPay > current_user.credit
      respond_to do |format|
      format.html { render notice: 'You do not have enough credit.' }
      format.html { render :new }
      format.json { render json: @session.errors, status: :unprocessable_entity }
    end
    else
      @userCredit = @userCredit - @totalPay
      current_user.save
      # redirect_to '/mysessions'
    end
    ###
  end

  def customers
    @sessions = Session.all.where(seller: current_user).order("created_at DESC")
  end

  def mysessions
    @sessions = Session.all.where(buyer: current_user).order("created_at DESC")
  end


  # GET /sessions/new
  def new
    @session = Session.new
    @cafe = Cafe.find(params[:cafe_id])
  end



  def update
    @session.start = convert_datetimes_to_pdt(@session.start)
    @session.finish = convert_datetimes_to_pdt(@session.finish)
  end


  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(session_params)
    @cafe = Cafe.find(params[:cafe_id])
    @seller = @cafe.user

    @session.cafe_id = @cafe.id
    @session.buyer_id = current_user.id
    @session.seller_id = @seller.id

    #convert to pacific time
    @session.start = convert_datetimes_to_pdt(@session.start)
    @session.finish = convert_datetimes_to_pdt(@session.finish)
    ###

    #subtract credits 
    @duration = ((@session.finish - @session.start)/ 1.hour).round(2)
    @totalPay = @cafe.rate * @duration

    if @totalPay > current_user.credit
      respond_to do |format|
      format.html { render notice: 'You do not have enough credit.' }
      format.html { render :new }
      format.json { render json: @session.errors, status: :unprocessable_entity }
    end
    else
      current_user.credit = current_user.credit - @totalPay
      current_user.save
    end
    ###

    respond_to do |format|
      if @session.save
        format.html { redirect_to @cafe, notice: 'Session was successfully created.' }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    def session_params
      params.require(:session).permit(:start, :finish, :id)
    end
end
