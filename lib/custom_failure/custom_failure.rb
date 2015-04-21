class CustomFailure < Devise::FailureApp
  def redirect_url
    new_user_session_url(:subdomain => 'secure')
  end

  def respond
    if http_auth?
      http_auth
    else
      # store_location!
      flash[:alert] = i18n_message unless flash[:notice]
      redirect_to :back 
    end
  end
end