class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::MimeResponds
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  def render_not_found
    render json: {message: 'Resource not found'}, status: :not_found
  end
end
