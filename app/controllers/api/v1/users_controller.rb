class Api::V1::UsersController < ApplicationController
  # This method creats
  # Ex: params = { auth: { provider: 'Github',
  #                        uid: '4da102ddf3fb208b8c18ffbe797e83bc'} }
  def create
    if !params[:auth]
      render json: { error: 'Auth params is missing' }
    else
      @user = User.from_omniauth(params[:auth])
      @token = @user.tokens.create
      render 'api/v1/users/show'
    end
  end
end
