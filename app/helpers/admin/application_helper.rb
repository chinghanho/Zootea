module Admin::ApplicationHelper

  def admin_sidebar_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    link_to link_path, class: "list-group-item #{class_name}" do
      (link_text +
      '<div class="pull-right">
        <span class="glyphicon glyphicon-chevron-right"></span>
      </div>').html_safe
    end
  end

end
