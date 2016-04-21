class PaymentsController < ApplicationController

  def new
  end

  def update
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

    current_user.subscribed = true
    current_user.credit += 25.00
    current_user.save

    redirect_to caves_path

  end



end
