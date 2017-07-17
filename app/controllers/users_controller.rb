class UsersController < ApplicationController
  def index
     @users = User.all
     puts @users
   end

   def show
     if current_user.present?
       @user = params[:id] ? User.find(params[:id]) : current_user
     else
       redirect_to root_path
     end
   end

   def new
     @user = User.new
   end
end
