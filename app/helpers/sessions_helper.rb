module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def sign_out
    if current_user
      current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
      cookies.delete(:remember_token)
      self.current_user = nil
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    current_user == user
  end

  def redirect_if_signed_in
    # redirect_to(user_path(current_user)) if signed_in?
    redirect_to(root_path) if signed_in?
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def signed_in_user
    unless signed_in?
      # store_location
      flash[:warning] = "Please sign in."
      redirect_to signin_url
    end
  end

  def admin_user
    redirect_to(user_path(current_user)) unless current_user.admin?
  end
end