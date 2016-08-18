class MoviesController < ApplicationController
  
  def index
  	@movies = Movie.all

    # unless params[:title_q].blank?
    #   @movies = @movies.where('title LIKE ?', "%#{params[:title_q]}%")
    # end

    @movies = Movie.title(params[:title_q]) if params[:title_q].present?
    @movies = Movie.director(params[:director_q]) if params[:director_q].present?
    @movies = Movie.duration(params[:duration_q]) if params[:duration_q].present?

    # unless params[:director_q].blank?
    #   @movies = @movies.where('director LIKE ?', "%#{params[:director_q]}%")
    # end

    # unless params[:duration_q].blank?
    #   case params[:duration_q]
    #     when "Under 90 minutes"
    #       @movies = @movies.where("runtime_in_minutes < 90")
    #     when "Between 90 and 120 minutes"
    #       @movies = @movies.where("runtime_in_minutes Between 90 AND 120")
    #     when "Over 120 minutes"
    #       @movies = @movies.where("runtime_in_minutes > 120")
    #   end
      
    # end

  end


  def show
  	 @movie = Movie.find(params[:id])
  end

  def new
  	@movie = Movie.new
  end

  def edit
  	@movie = Movie.find(params[:id])
  end

  def create
  	@movie = Movie.new(movie_params)

  	if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
  	else
  	  render :new
  	end
  end

  def update
  	@movie = Movie.find(params[:id])

  	if @movie.update_attributes(movie_params)
  	  redirect_to movie_path(@movie)
  	else
  	  render :edit
  	end
  end

  def destroy
  	@movie = Movie.find(params[:id])
  	@movie.destroy
  	redirect_to movies_path
  end

  protected

  def movie_params
  	params.require(:movie).permit(
  	  :title, :release_date, :director, :runtime_in_minutes, :description, :image
  	)
  end

end

