class CatsController < ApplicationController
  before_action :ensure_cat_owner, only: [:edit, :update]

  def index
    @all_cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cats_params)
    @cat.user_id = current_user.id

    if @cat.save

      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cats_params)
      redirect_to cat_url(@cat)
    else
      render(json: @cat.errors.full_messages, status: :unprocessable_entity)
    end
  end

  private

  def cats_params
    params.require(:cat).permit(:id, :birth_date, :color, :name, :sex, :description, :user_id)
  end

  def ensure_cat_owner
    current_cat = current_user.cats.where('id = ?', params[:id])
    redirect_to cats_url if current_cat.empty?
  end
end
