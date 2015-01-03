class IdentifiersController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  def show
    identifiable = Identifier.find_by_code(params[:id]).identifiable
    render json: identifiable
  end
end
