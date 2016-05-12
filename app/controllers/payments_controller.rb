class PaymentsController < InheritedResources::Base

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # POST /payments
  # POST /payments.json
  def create
    @Payment = Payment.new
    @Payment.user_id = current_user

    Stripe.api_key = ENV["STRIPE_API_KEY"]
       token = params[:stripeToken]

       begin
         charge = Stripe::Charge.create(
           :amount => (25 * 100).floor,
           :currency => "usd",
           :card => token
           )
         flash[:notice] = "Thanks for purchasing!"
         rescue Stripe::CardError => e
           flash[:danger] = e.message
       end

    @Payment.stripe_id = charge.id
    @Payment.amount = charge.amount

    if current_user.subscribed != true
      current_user.subscribed = true
      current_user.credit = 25.00
    else
      current_user.credit = current_user.credit + 25.00
    end

    current_user.save
    redirect_to caves_path
  end

  def update
    # Stripe.api_key = ENV["STRIPE_API_KEY"]
    #    token = params[:stripeToken]
    #
    #    begin
    #      charge = Stripe::Charge.create(
    #        :amount => (25 * 100).floor,
    #        :currency => "usd",
    #        :card => token
    #        )
    #      flash[:notice] = "Thanks for purchasing!"
    #      rescue Stripe::CardError => e
    #        flash[:danger] = e.message
    #    end
    #
    # @Payment.stripe_id = charge.id
    # @Payment.amount = charge.amount
    #
    # current_user.subscribed = true
    # current_user.credit += 25.00
    # current_user.save
    #
    # redirect_to caves_path

  end

private

    #Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:user_id, :amount, :strip_id)
    end

  end
