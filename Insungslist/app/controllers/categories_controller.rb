class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      flash[:success] = "Created successfully!"
      redirect_to root_path
    else
      flash[:alert] = 'There was a problem saving the category.'
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
