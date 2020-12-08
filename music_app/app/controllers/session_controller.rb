class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.find_by(session_params)
        if @user
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
        params.require(:user).allow(:session_token)
    end

end