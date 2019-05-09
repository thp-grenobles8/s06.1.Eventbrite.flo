class EventsController < ApplicationController
  before_action :user_is_log, only: [:new, :create]
  def show
    @event_show = Event.find(params['id'])
  end

  def new
    @new_event = Event.new
  end

  def update
    @update_event = Event.find(params[:id])
    if @update_event.update(
      start_date: params[:event_start_date],
      title: params[:event_title],
      duration: params[:event_duration],
      price: params[:event_price],
      description: params[:event_description]
    )
      flash[:success] = "L'événement a bien été modifié !"
      redirect_to @update_event
    else
      flash[:error] = "L'événement n'a pas pu être mis à jour !"
      redirect_to @update_event
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
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
    @edit_event = Event.find(params[:id])
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
