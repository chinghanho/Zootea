module ApplicationHelper

  def full_title(page_title)
    base_title = CONFIG['app_name']

    content_tag(:title) do
      if page_title.empty?
        base_title
      else
        "#{page_title} | #{base_title}"
      end
    end
  end

  def nav_link(link_text, link_path, html_options = nil)
    class_name = current_page?(link_path) ? 'active' : ''
    class_names = [html_options, class_name].join(' ')

    content_tag(:li, :class => class_names) do
      link_to link_text, link_path
    end
  end

  def link_to_google_maps(link_text, address)
    google_maps_base_url = "https://www.google.com/maps/preview"
    query = CGI.escape address
    query_base = "?q=#{query}"
    url = "#{google_maps_base_url}#{query_base}"
    link_to link_text, url, target: '_blank'
  end

  def controller_namespace
    controller_path.split('/').first
  end

end
