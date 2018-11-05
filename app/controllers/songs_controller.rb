class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def edit
    @song = Song.find(params[:id])
  end


  def create
    @song = Song.new(params.require(:song).permit(:title, :release_year, :released, :genre, :artist_name))
    if @song.valid?
      @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def update
    @song = Song.find(params[:id])
    if @song.update(params.require(:song).permit(:title, :release_year, :released, :genre, :artist_name))
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    Song.destroy(params[:id])
    redirect_to songs_path
  end


  private
  def song_params(*args)
    params.require(:song).permit(*args)
  end
end
