module ApplicationHelper
  def category_name(id)
    Category.find(id).name
  end

  def nav_link(title, path, **options)
    css_class = if options[:class]
      options[:class] + (current_page?(path) ? ' active' : '')
    else
      current_page?(path) ? 'active' : ''
    end

    link_to title, path, options.merge(class: css_class)
  end

end
