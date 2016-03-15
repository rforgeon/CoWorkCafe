class SessionsController < InheritedResources::Base

  #before_action :set_order, only [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
    @cafe = Cafe.find(params[:cafe_id])
  end

  # GET /sessions/1/edit
  def edit
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

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /session/1
  # DELETE /session/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to caves_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    def session_params
      params.require(:session).permit(:start, :finish)
    end
end
