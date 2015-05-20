class GeckoController < ApplicationController
  before_action -> { doorkeeper_authorize! :gecko }

  def show
    widget = find_widget_by_name(params[:id])

    puts widget.inspect

    if widget.present?
      render json: widget.call
    else
      render_not_found
    end
  end

  private

  def find_widget_by_name(name)
    @widgets_cache ||= {
      'some_text' => lambda do
        {
          'item' => [
            {
              'text' => 'This is some text',
              'type' => 0
            }]
        }
      end
    }

    @widgets_cache[name]
  end
end
