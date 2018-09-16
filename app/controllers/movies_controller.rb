# The movies controller.
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def create
    permitted = params.require(:movie).permit(:movie,
                                              :title,
                                              :rating,
                                              :release_date)
    @movie = Movie.create!(permitted)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def show
    @movie = Movie.find params[:id]
  end

  def update;  end

  def destroy; end
end
