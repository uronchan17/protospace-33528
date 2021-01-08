class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    set_prototype
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    set_prototype
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    set_prototype
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      @prototype.title
      @prototype.catch_copy
      @prototype.concept
      @prototype.image
      render :edit
    end
  end

  def destroy
    set_prototype
    @prototype.destroy
    redirect_to root_path
  end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end


end
