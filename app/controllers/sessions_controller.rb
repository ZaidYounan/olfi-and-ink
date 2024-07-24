class SessionsController < ApplicationController
  before_action :authenticate, only: :destroy

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new
  end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      @session = user.sessions.create!
      Current.user = user
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

      redirect_to root_path, notice: "Signed in successfully"
    else
      redirect_to sign_in_helooni_path(email_hint: params[:email]), alert: "That email or password is incorrect"
    end
  end

  def destroy
    session = Current.user.sessions.find(params[:id])
    session.destroy
    Current.user = nil
    redirect_to root_url, notice: "That session has been logged out"
  end
end
