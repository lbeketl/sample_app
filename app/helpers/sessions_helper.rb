module SessionsHelper
#Вхід даного користувачв
  def log_in(user)
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  # Запоминает пользователя в постоянном сеансе.
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      @current_user ||= user if session[:session_token] == user.session_token
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

   # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end


  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Закриває постійну сесію.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    # reset_session
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Перенаправить по сохраненному адресу или на страницу по умолчанию.
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Запоминает URL.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  

end
