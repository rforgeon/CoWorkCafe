class ImagesController < InheritedResources::Base

  before_action :authenticate_user!
  before_action :set_cafe


  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.cafe_id = @cafe.id

    respond_to do |format|
      if @image.save
        format.html { redirect_to @cafe, notice: 'your image was successfully added.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @cafe, notice: 'image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to @cafe, notice: 'image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private

  def set_image
    @image = Image.find(params[:id])
  end

  def set_cafe
    @cafe = Cafe.find(params[:cafe_id])
  end

  def check_user
    unless current_user == @cafe.user_id
      redirect_to @cafe, alert: "Sorry, this cafe belongs to someone else"
    end
  end

    def image_params
      params.require(:image).permit(:cafe_id, :cafephoto)
    end
end
