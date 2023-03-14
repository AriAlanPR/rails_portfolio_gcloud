class WelcomeController < ApplicationController
  protect_from_forgery with: :null_session

  def index
  end

  #POST /send_email
  def send_email
    # Tell the UserMailer to send a welcome email after save
    # UserMailer.with(user: @user).welcome_email.deliver_later
    DevMailer.greeting_email(email_params["email"]).deliver_later

    respond_to do |format|
      format.html { redirect_to(presentations_url, notice: 'Email has been sent.') }
      format.json { render json: {:state => 'ok' }.to_json, status: 200 }
    end
  end

  private
  def email_params
    params.permit(:email)
  end
end
