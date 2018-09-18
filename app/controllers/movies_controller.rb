# The movies controller.
class MoviesController < ApplicationController
  def index
    @all_ratings = Movie
                   .distinct(:rating)
                   .pluck(:rating)
    session[:ratings] = if params[:ratings].nil? && session[:ratings].nil?
                          @all_ratings
                        elsif !params[:ratings].nil?
                          params[:ratings].keys
                        else
                          session[:ratings]
                        end

    session[:sort] = params[:sort] unless params[:sort].nil?
    @movies = case session[:sort]
              when 'title'
                Movie.where(rating: session[:ratings]).order(:title)
              when 'release_date'
                Movie.where(rating: session[:ratings]).order(:release_date)
              else
                Movie.where(rating: session[:ratings])
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
