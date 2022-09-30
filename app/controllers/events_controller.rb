class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @categories = [["Music", "music"], ["Politic", "politic"], ["Sports", "sports"], ["Food Festival", "food festival"], ["Automotive", "automotive"], ["Others", "others"]]
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

  def search
    @events = Event.where("events.name LIKE ?", "%#{params[:name]}%")
    render :index
  end

  def event_chosen
    @events =  current_user.booked_event
  end

  def search_date
    @events = Event.all
  end

  def show_by_date
    @events = Event.where("DATE(events.date) LIKE ?", params[:date])
    render :search_date
  end

  def show_ticket
    require "rqrcode"

    @event = current_user.booked_event.find(params[:id])

    qr_info = ["ticket holder", current_user.username] + ["event_name", @event.name]

    qr = RQRCode::QRCode.new(qr_info.to_s)

    @qr_svg = qr.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 4,
      standalone: true,
      use_path: true
    )
  end

  private
    def event_params
      params.require(:event).permit(:name, :description, :date)
    end
end