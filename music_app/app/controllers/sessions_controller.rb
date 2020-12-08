class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(session_params)
        if @user
            @user.reset_session_token!
            session[:session_token] = @user.session_token
            redirect_to user_url
        else
            render :new
        end
    end

    def destroy
        @user = User.find_by(session_params)
        session[:session_token] = nil
        if @user
            @user.reset_session_token!
        end
    end

    private

    def session_params
        params.require(:user).permit(:username, :password, :session_token)
    end

end