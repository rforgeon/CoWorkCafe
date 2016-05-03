class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper


  def create
    super
    # @user = User.new
    # @user.credit = 0.00
  end

  def new
    super
  end

  def edit
    super
  end

end
