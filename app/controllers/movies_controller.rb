# The movies controller.
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def create
    params.require(:movie).permit(:title,
                                  :rating,
                                  :release_date)
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
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
