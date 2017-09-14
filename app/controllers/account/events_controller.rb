class Account::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @events = current_user.events.order("created_at DESC")
  end

  def publish
    @event = Event.find(params[:id])
    @event.publish!
    redirect_to :back
  end

  def hide
    @event = Event.find(params[:id])
    @event.hide!
    redirect_to :back
  end

  def edit
    find_event_and_check_permission
  end

  def update
    find_event_and_check_permission

    if @event.update(event_params)
      redirect_to account_events_path, notice: "编辑成功"
    else
      render :edit
    end
  end

  def destroy
    find_event_and_check_permission

    @event.destroy

    redirect_to account_events_path, alert: "删除成功"
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def find_event_and_check_permission
    @event = Event.find(params[:id])

    if current_user != @event.user
      redirect_to root_path, alert: "You have no permission"
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :endtime, :important_class, :executive_method,:is_hidden)
  end

end
