class UsersController < ApplicationController
  before_action :user_is_user_show, only: [:show]
  def index
  end

  def show
    @user = User.find(params['id'])
    @id = params['id']
  end

  def destroy
  end

  def edit
    @user = User.find(params['id'])
  end

  def update
    @update_user = User.find(params[:id])
    if @update_user.update(
      description: params[:description],
      first_name: params[:first_name],
      last_name: params[:last_name]
      )
      flash[:update_success] = " Le profil a bien été mis à jour !"
      redirect_to @update_user
    else
      flash[:update_warning] = " Le profil n'a pas pu être mis à jour !"
      redirect_to @update_user
    end

  end

  def create
  end

  def new
  end

  private

  def user_is_user_show
    unless current_user == User.find_by(id: params[:id])
      flash[:not_author] = "Tu ne peux pas accéder aux profils des autres utilisateurs"
      redirect_to '/'
    end
  end
end
