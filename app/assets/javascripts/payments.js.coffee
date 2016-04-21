jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  cafe.setupForm()

payment =
  setupForm: ->
    $('#new_payment').submit ->
      if $('input').length > 6
        $('input[type=submit]').attr('disabled', true)
        Stripe.bankAccount.createToken($('#new_payment'), payment.handleStripeResponse)
        false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_payment').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_payment')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)
