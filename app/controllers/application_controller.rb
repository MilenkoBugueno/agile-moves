class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

#To set the locale for more than one request.
  before_filter :set_locale
  private
  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

#To prevent routing Error, when setting locale
  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  def log_admin(title)
    @activity = AdminLog.new
    @activity.user_id = current_user
    @activity.username = current_user.name
    @activity.title = title
    @activity.browser = request.env['HTTP_USER_AGENT']
    @activity.ip_address = request.env['REMOTE_ADDR']
    @activity.controller = controller_name
    @activity.action = action_name
    @activity.params = params.inspect
    @activity.save
  end


  def wp_publish(host, user, pwd, content, title, categories)

    wp = Rubypress::Client.new(:host => host, :username => user, :password => pwd)

    articleid = wp.newPost(:content => {:post_status => "publish", :post_date => Time.now, :post_content => content, :post_title => title, :terms_names => {:category => categories}})

    # Mark for garbage collection
    wp = nil

    # TODO Errorhandling
  end

  def wp_getCategories(host, user, pwd, blog_id)

    wp = Rubypress::Client.new(:host => host, :username => user, :password => pwd)

    blog_tax = wp.getTerms(:blogid => blog_id, :username => user, :password => pwd, :taxonomy => "category")

    categories = Array.new
    blog_tax.each do |cat|
      categories = categories.push(cat["name"])
    end
    wp = nil
    return categories
  end

  def wp_getUsersBlogs(host, user, pwd)

    wp = Rubypress::Client.new(:host => host, :username => user, :password => pwd)

    user_blogs = wp.getUsersBlogs()

    blogs = Array.new
    user_blogs.each do |blog|
      blogs = blogs.push(blog["url"].sub(/^http\:\/\//, '').delete('/'))
    end
    wp = nil
    return blogs
  end

  def wp_pre_publish(blogstringarray)

    i = 0
    # Dieses Array ist für die Url [0] und die Kategorie [1] aus dem blogstringarray
    blogsarray = Array.new

    # Dieser Hash soll die url als key haben und die Kategorien als Array zum Key
    bloghash = Hash.new
    pre_blog = nil

    blogstringarray.each do |blog|
      blogsarray = Array.new
      blogsarray = blog.split("!")
      if i == 0
        bloghash[blogsarray[0]] = Array.new
        bloghash[blogsarray[0]].push(blogsarray[1])
        pre_blog = blogsarray[0]
      else
        if pre_blog == blogsarray[0]
          bloghash[blogsarray[0]].push(blogsarray[1])
          pre_blog = blogsarray[0]
        else
          bloghash[blogsarray[0]] = Array.new
          bloghash[blogsarray[0]].push(blogsarray[1])
          pre_blog = blogsarray[0]
        end
      end
      i = i + 1
    end
    return bloghash
  end
end
