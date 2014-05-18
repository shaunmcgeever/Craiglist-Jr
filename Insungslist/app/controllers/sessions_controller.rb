class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user.password == params[:session][:password]
      flash[:success] = "Welcome #{@user.email}!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "There was an error with that username and/or password."
      render :new
    end
  end

  def destroy
    flash[:success] = "Signed out successfully."
    session.clear
    redirect_to root_path
  end

end
