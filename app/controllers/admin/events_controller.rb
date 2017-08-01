class Admin::EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :require_is_admin
  layout "admin"

  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.order("created_at DESC")
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to admin_events_path
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
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy

    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :endtime, :is_hidden)
  end
end
