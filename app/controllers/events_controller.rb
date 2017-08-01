class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  def index
    @events = Event.where(:is_hidden => false).order("created_at DESC")
  end

  def show
    @event = Event.find(params[:id])

    if @event.is_hidden
      flash[:warning] = "This events already archived"
      redirect_to root_path
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy

    redirect_to events_path, alert: "删除成功"
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :endtime, :is_hidden)
  end
end
