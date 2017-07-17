class CollaboratorsController < ApplicationController


  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not added. Please try again."
      render :show
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:user_id])
    @collaborator = Collaborator.find_by(wiki_id: @wiki.id, user_id: params[:user_id])

   if @collaborator.destroy
     flash[:notice] = "Collaborator was deleted."
     redirect_to @wiki
   else
     flash[:alert] = "Collaborator couldn't be deleted. Try again."
     redirect_to edit_wiki_path
   end

  end




end
