module ApplicationHelper
  def login_helper
    if current_user.is_a?(GuestUser)
      (link_to "Sign Up", new_user_registration_path) +
      "<br>".html_safe +
      (link_to "Login", new_user_session_path)
    else
      link_to "Logout", destroy_user_session_path, method: :delete
    end
  end

  def login_helper_l
    if current_user.is_a?(GuestUser)
      (link_to "Login", new_user_session_path)
    else
      (link_to "Logout", destroy_user_session_path, method: :delete)
    end
  end

  def login_helper_r
    if current_user.is_a?(GuestUser)
     "<li class='mobile-login' >".html_safe + (link_to "Sign Up", new_user_registration_path) + "</li>".html_safe
    end
  end


  def source_helper(styles)
    if session[:source]
      greeting = "Thanks for visiting me from #{session[:source]}, please feel free to #{ link_to 'contact me', contact_path }."
      content_tag(:div, greeting.html_safe, class: styles)
    end
  end

  def copyright_generator
    YomodaViewTool::Renderer.copyright 'Kanji Yomoda', 'All rights reserved'
  end

  def nav_items
    [
        {
            url: root_path,
            title: 'Home'
        },
        {
            url: about_me_path,
            title: 'About Me'
        },
        {
            url: contact_path,
            title: 'Contact'
        },
        {
            url: blogs_path,
            title: 'Blog'
        },
        {
            url: portfolios_path,
            title: 'Portfolio'
        },
        {
            url: tech_news_path,
            title: 'Tech News'
        },
    ]
  end

  def nav_helper style, tag_type
    nav_links  = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end
    nav_links.html_safe
  end

  def active? path
    "active" if current_page? path
  end

  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generator alert
    end
  end

  def alert_generator msg
    js add_gritter(msg, time: 3000)
  end

end

