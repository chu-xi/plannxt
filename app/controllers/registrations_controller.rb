class RegistrationsController < ApplicationController
        # instantiates new user
    def new
      @user = User.new
    end
    def create
      @user = User.new(user_params)
      if @user.save
        # deliver_now is provided by ActiveJob.
        # WelcomeMailer.with(user: @user).welcome_email.deliver_now
        
        # stores saved user id in a session
        session[:user_id] = @user.id
        redirect_to edit_page_path, notice: 'Successfully created account! Automatically logged in!'
      else
        redirect_to sign_up_path, notice: 'Create account failed! ' + @user.errors.full_messages.join('; ') + "."
      end
    end

    # def toggle
    #   if admin?
    #     @user = User.find_by(name: params[:user])
    #     @user.enabled = params[:on] || 0
    #     @user.save
    #   else
    #     redirect_to '/'
    #   end
    # end

    # def retrieve
    #   if admin?
    #     @user = User.find_by(name: params[:user])
    #     render json: @user.to_json
    #   else
    #     redirect_to '/'
    #   end
    # end

    private

    def user_params
      # strong parameters
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
