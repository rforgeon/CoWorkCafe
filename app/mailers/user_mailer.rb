class UserMailer < ActionMailer::Base

  #config.action_mailer.raise_delivery_errors = true

  ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :domain         => 'mail.google.com',
  :port           => 587,
  :user_name      => 'rforgeon@gmail.com',
  :password       => 'Show3rOctopus',
  :authentication => :plain,
  :enable_starttls_auto => true
}


  default from: 'rforgeon@gmail.com'

  def session_created_email(user,cafe,session_s,session_f)
   @cafe = cafe
   @user = user
   @session_start = session_s
   @session_finish = session_f
   #attachments['cafeImage.jpg'] = File.read(@cafe.image.path(:medium))
   @url  = 'https://www.nativenomadic.com/'
   mail(to: @user.email, subject: 'Your native|Nomadic Session')
  end

  def session_created_owner_email(user,cafe,session_s,session_f,seller)
   @cafe = cafe
   @user = user
   @seller = seller
   @session_start = session_s
   @session_finish = session_f
   attachments['userImage.jpg'] = File.read(@user.avatar.path(:medium))
   #attachments['cafeImage.jpg'] = File.read(@cafe.image.path(:medium))
   @url  = 'https://www.nativenomadic.com/'
   mail(to: @seller.email, subject: 'New native|Nomadic Session')
  end


end
