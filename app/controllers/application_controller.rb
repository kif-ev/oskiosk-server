class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::MimeResponds

  def render_not_found
    render json: {message: 'Resource not found'}, status: :not_found
  end
end
