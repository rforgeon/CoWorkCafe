jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  cafe.setupForm()

cafe =
  setupForm: ->
    $('#new_cafe').submit ->
      if $('input').length > 6
      $('input[type=submit]').attr('disabled', true)
      Stripe.bankAccount.createToken($('#new_cafe'), cafe.handleStripeResponse)
      false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_cafe').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_cafe')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)
