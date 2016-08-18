class Admin::UsersController < ApplicationController
	before_filter :restrict_access
	
	def index	
	  	@users = User.all.page(params[:page]).per(5)
	end

	 def show
	  	 # @user = User.find(params[:id])
	  	 redirect_to admin_users_path
	 end

	def new
	  	@user = User.new
	end

	def edit
	  @user = User.find(params[:id])
	end

	def create
	  	@user = User.new(user_params)

		if @user.save
		    session[:user_id] = @user.id # auto log in
		   	# redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
		   	render :index
		   	# format.html { redirect_to action: :index}
		else
		    render :new
		end
	end
	
	def update
		@user = User.find(params[:id])

	  	if @user.update_attributes(user_params)
	  	  	redirect_to admin_users_path
	  	else
	  	  render :edit
	  	end
	end

	protected

	def user_params
	    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
	end

end
