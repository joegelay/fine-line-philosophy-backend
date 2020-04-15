class AuthenticationController < ApplicationController
    def login 
        @user = User.find_by(username: params[:username])

        if !@user 
            render json: {message: "Cannot find username"}
        else 
            if !@user.authenticate(params[:password])
                render json: {message: "Password incorrect"}
            else 
                payload = {
                    user_id: @user.id 
                }
                secret_key = Rails.application.secret_key_base
                token = JWT.encode payload, secret_key

                render json: { token: token}
            end 
        end 
    end 
end
