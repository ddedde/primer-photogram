class LikesController < ApplicationController
  def index
    @likes = Like.all

    respond_to do |format|
      format.html
      format.csv { send_data @likes.to_csv, filename: "likes.csv" }
    end
  end

  def show
    @like = Like.find(params[:id])
  end

  def new
    @like = Like.new
  end

  def create
    @like = Like.new
    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    if @like.save
      redirect_to :back, :notice => "Like created successfully."
    else
      render 'new'
    end
  end

  def edit
    @like = Like.find(params[:id])
  end

  def update
    @like = Like.find(params[:id])

    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    if @like.save
      redirect_to "/likes", :notice => "Like updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @like = Like.find(params[:id])

    @like.destroy

    redirect_to :back, :notice => "Like deleted."
  end
end
