class ReviewsController < InheritedResources::Base

before_action :set_review, only: [:edit, :update, :destroy]
before_action :set_cafe
before_action :authenticate_user!
before_action :check_user, only: [:edit, :update, :destroy]
before_action :check_subscribed, only: [:create]


  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.cafe_id = @cafe.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @cafe, notice: 'Your review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @cafe, notice: 'Your review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @cafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Your review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    def set_review
      @review = Review.find(params[:id])
    end

    def check_user
      unless (@review.user == current_user)
        redirect_to cafe_path(@cafe), alert: "Sorry, this review belongs to someone else"
      end
    end

    def check_subscribed
      unless current_user.subscribed
        redirect_to "/pages/pricing", alert: "You must be a member to write a review"
      end
    end

    def set_cafe
      @cafe = Cafe.find(params[:cafe_id])
    end


    def review_params
      params.require(:review).permit(:rating, :comment, :user_id, :cafe_id)
    end
end
