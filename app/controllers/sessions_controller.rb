class SessionsController < InheritedResources::Base

  #before_action :set_order, only [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  helper_method :convert_datetimes_to_pdt
  def convert_datetimes_to_pdt(field)
    field = field + Rational(7,24) #hours in day (UTC is 7 hours ahead of Pacific Time)
  end

  def customers
    @sessions = Session.all.where(seller: current_user) #.session("created_at DESC")
  end

  def mysessions
    @sessions = Session.all.where(buyer: current_user) #.session("created_at DESC")
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

    @session.start = convert_datetimes_to_pdt(@session.start)
    @session.finish = convert_datetimes_to_pdt(@session.finish)

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
      params.require(:session).permit(:start, :finish)
    end
end
