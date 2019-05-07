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
  end

  def update
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
