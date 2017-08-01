module Admin::EventsHelper
  def render_admin_event_status(event)
    if event.is_hidden
      content_tag(:span, "", :class => "fa fa-lock")
    else
      content_tag(:span, "", :class => "fa fa-unlock")
    end
  end
end
