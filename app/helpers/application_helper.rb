module ApplicationHelper
    # Checks which navbar link user is on
    def active_class(link_path)
        current_page?(link_path) ? "active" : ""
    end
end
