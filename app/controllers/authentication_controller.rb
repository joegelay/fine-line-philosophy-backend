class AuthenticationController < ApplicationController
    def login 
        @user = User.find_by(username: params[:username])

        if !@user 
            render json: {message: "Username or password incorrect."}
        else 
            if !@user.authenticate(params[:password])
                render json: {message: "Username or password incorrect."}
            else 
                payload = {
                    user_id: @user.id,
                    username: @user.username
                }
                secret_key = Rails.application.secret_key_base
                token = JWT.encode payload, secret_key

                render json: { token: token}
            end 
        end 
    end 
end
