class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all
    @users = User.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.create(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def attend
    attend = current_user.event_atendees.build(event_id: params[:event_id])

    if attend.save
      redirect_to event_path(id: params[:event_id])
    else
      render :event, status: :unprocessable_entity
    end
  end

  private
    # def attend_params
    #   params.require(:attend).permit(:event_id)
    # end

    def event_params
      params.require(:event).permit(:name, :description, :date)
    end
end