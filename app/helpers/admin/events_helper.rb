module Admin::EventsHelper
  def render_admin_event_status(event)
    if event.is_hidden
      "(Hidden)"
    else
      "(Public)"
    end
  end
end
