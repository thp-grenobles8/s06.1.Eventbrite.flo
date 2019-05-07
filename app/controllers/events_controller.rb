class EventsController < ApplicationController
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
      start_date: Time.now + 1,
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
end
