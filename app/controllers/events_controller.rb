class EventsController < ApplicationController
  before_action :user_is_log, only: [:new, :create]
  def show
    @event_show = Event.find(params['id'])
  end

  def new
    @new_event = Event.new
  end

  def update
  end

  def destroy
  end

  def create
    @create_event = Event.new(
      start_date: DateTime.new(params[:start_date_day].split("-")[0].to_i,
                               params[:start_date_day].split("-")[1].to_i,
                               params[:start_date_day].split("-")[2].to_i,
                               params[:start_date_hour].split("-")[0].to_i,
                               params[:start_date_hour].split("-")[1].to_i,
                               params[:start_date_hour].split("-")[2].to_i
                             ),
      duration: params[:duration].to_i,
      title: params[:title],
      description: params[:description],
      price: params[:price],
      location: params[:location],
      admin: current_user
    )
    if @create_event.save
      Participation.create(
        user: current_user,
        event: @create_event
      )
      flash[:notice] = "Ton event a été ajouté !"
      redirect_to @create_event
    else
      flash[:warning] = "Ton event n'est pas valide !"
      render :new
    end
  end

  def edit
  end

  def index
    @events = Event.all
  end

  private

  def user_is_log
    unless user_signed_in?
      flash[:not_author] = "Tu ne peux pas créer d'événement si tu n'es pas connecté"
      redirect_to '/'
    end
  end
end
