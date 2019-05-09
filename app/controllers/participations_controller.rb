class ParticipationsController < ApplicationController
  before_action :user_participation, only:[:create]

  def index
    @event = Event.find(params[:event_id])
    @participations = @event.participations
  end

  def create
    @event = Event.find(params[:event_id])
    Participation.create(user: current_user, event: @event )
    @amount = @event.price

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    flash[:success] = "Vous participez à l'événement"
    redirect_to request.referrer

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to :back
  end

  private

  def user_participation
    unless user_signed_in?
      flash[:error] = "Tu ne peux pas t'inscrire si tu n'es pas connecté"
      redirect_to request.referrer
    end
    if current_user == Event.find(params[:event_id]).admin
      flash[:error] = "Tu ne peux pas t'inscrire à ton propre événement"
      redirect_to request.referrer
    elsif Event.find(params[:event_id]).users.include? current_user
      flash[:error] = "Tu participe déjà à cet événement"
      redirect_to request.referrer
    end
  end
end
