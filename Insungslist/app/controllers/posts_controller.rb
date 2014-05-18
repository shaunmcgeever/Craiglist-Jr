class PostsController < ApplicationController
  before_action :find_category
  before_action :find_post, :only => [:edit, :update, :destroy]

  def new
    @user = User.find(session[:user_id])
    @post = Post.new
    @categories = Category.all
  end

  def create
    puts "THESE ARE THE PARAMS: #{params}"
    @post = @category.posts.build(post_params)
    if @post.save
      flash[:success] = "Thank you for your post!"
      redirect_to category_path(@category)
    else
      flash[:alert] = "That post could not go through. Please try again."
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @categories = Category.all

  end

  def update
    puts "PARAMS ARE: #{params}"
    if @post.update_attributes(post_params)
      flash[:success] = "#{@post.title} updated!"
      redirect_to category_path(@category)
    else
      flash[:alert] = "That post could not go through. Please try again."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to category_path(@category)
  end

  private

  def post_params
    params.require(:post).permit(:body, :title, :category_id, :user_id)
  end

  def find_category
    @category = Category.find(params[:category_id])
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
