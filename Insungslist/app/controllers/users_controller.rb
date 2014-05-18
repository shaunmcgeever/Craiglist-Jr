class UsersController < ApplicationController
  before_action :check_user, :only => [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id ##potentially make create_session helper
      redirect_to root_path
    else
      flash[:alert] = "Something was wrong"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @posts_and_categories = Hash[@posts.zip(@posts.map { |post| post.category.name })]
    @categories = (@user.posts.map {|x| x.category}).uniq
    @posts_by_user = @categories.map do |category|
      category.posts.where(user_id: @user)
    end
  end

  private

  def check_user
    puts "SESSION ID #{session[:user_id]}"
    puts "PARAMS ID #{params[:id]}"
    if session[:user_id].to_s == params[:id].to_s
      return true
    else
      flash[:alert] = "You are not authoriezed to visit that page!"
      redirect_to root_path
      #redirect_to '/public/500.html'
    end
  end


  def user_params
    params.require(:user).permit(:email, :password)
  end

end
