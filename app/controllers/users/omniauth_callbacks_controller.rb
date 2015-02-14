class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def raven
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    #TODO: remove @user.admin? when the site goes live.


    unless @user.petrean? || @user.medwards?
      flash[:error] = 'You are not registered as a current Peterhouse student. ' +
          'Ticket sales to University members go on sale on Monday 16th February at 9pm. ' +
          'If you believe this is an error please contact ticketing@peterhousemayball2015.com.'
    end

    if @user.persisted?
      unless @user.petrean? || @user.medwards?
        return redirect_to '/'
      end
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Raven") if is_navigational_format?
    else
      session["devise.raven_data"] = request.env["omniauth.auth"]
      redirect_to '/'
      # redirect_to new_user_registration_url
    end
  end
end
