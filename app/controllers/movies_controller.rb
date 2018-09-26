# The movies controller.
class MoviesController < ApplicationController

  def permitted
    params.require(:movie).permit(:movie,
                                  :title,
                                  :rating,
                                  :release_date,
                                  :threshold,
                                  :for_kids,
                                  :with_many_fans,
                                  :recently_reviewed)
  end

  def movies_with_filters
    @movies = Movie.with_good_reviews(params[:threshold])
    %w[for_kids with_many_fans recently_reviewed].each do |filter|
      @movies = @movies.send(filter) if params[filter]
    end
  end

  def index
    @all_ratings = Movie.all_ratings

    session[:ratings] = params[:ratings].keys if params[:ratings]
    session[:ratings] = @all_ratings if session[:ratings].nil?

    session[:sort] = params[:sort] unless params[:sort].nil?

    @movies = Movie.ordered_ratings(session[:ratings], session[:sort])
  end

  def show
    @movie = Movie.find params[:id]
  end

  def create
    @movie = Movie.new(permitted)
    if @movie.save
      flash[:notice] = "<em>#{@movie.title}</em> was successfully created."
      redirect_to movies_path
    else
      render 'new'
    end
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    if @movie.update_attributes(permitted)
      flash[:notice] = "<em>#{@movie.title}</em> was successfully updated."
      redirect_to movie_path(@movie)
    else
      render 'edit' # note, 'edit' template can access @movie's field values!
    end
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:warning] = "<em>#{@movie.title}</em> was successfully deleted."
    redirect_to movies_path
  end
end
