# The movies controller.
class MoviesController < ApplicationController
  def index
    @movies = case params[:sort]
              when 'title'
                @sort = :title
                Movie.all.order(:title)
              when 'release_date'
                @sort = :release_date
                Movie.all.order(:release_date)
              else
                Movie.all
              end
  end

  def show
    @movie = Movie.find params[:id]
  end

  def create
    permitted = params.require(:movie).permit(:movie,
                                              :title,
                                              :rating,
                                              :release_date)
    @movie = Movie.create!(permitted)
    flash[:notice] = "<em>#{@movie.title}</em> was successfully created."
    redirect_to movies_path
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie].permit!)
    flash[:notice] = "<em>#{@movie.title}</em> was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:warning] = "<em>#{@movie.title}</em> was successfully deleted."
    redirect_to movies_path
  end
end
