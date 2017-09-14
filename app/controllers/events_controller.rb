class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :find_event_and_check_permission, only: [:edit, :update, :destroy]

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
    @event.user = current_user

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
    find_event_and_check_permission
  end

  def update
    find_event_and_check_permission
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    find_event_and_check_permission

    @event.destroy

    redirect_to events_path, alert: "删除成功"
  end

  private

  def find_event_and_check_permission
  @event = Event.find(params[:id])

    if current_user != @event.user
      redirect_to root_path, alert: "You have no permission"
    end
  end


  def event_params
    params.require(:event).permit(:title, :description, :endtime, :important_class, :executive_method, :is_hidden)
  end
end
