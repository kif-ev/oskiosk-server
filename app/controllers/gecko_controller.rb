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
      end,
      'hourly_beer_by_conference' => lambda do
        format_for_geckoboard_linechart(hourly_consumption)
      end
    }

    @widgets_cache[name]
  end

  def format_for_geckoboard_linechart(data_points)
    return if data_points.blank?

    inc_from = DateTime.current.at_beginning_of_hour.to_formatted_s(:iso8601)

    {
      'x_axis': {
        'type': 'datetime'
      },
      'series': ['KIF', 'KoMa', 'ZaPF', 'Team'].collect do |conf|
        conf_data_points = extract_data_points_for(data_points, conf)
        next if conf_data_points.blank?
        {
          'name': conf,
          'data': conf_data_points,
          'incomplete_from': inc_from
        }
      end
    }
  end

  def extract_data_points_for(data_points, conf)
    data_points.select { |dp| dp[1] == conf }.
      collect { |dp| [DateTime.parse(dp[0]).to_s(:iso8601), dp[2].to_i] }
  end

  def hourly_consumption(product_criteria: {})
    ActiveRecord::Base.connection.execute(
      TransactionItem.ransack(
        money_transaction_transaction_type_eq: 'cart_payment',
        product_tags_name_cont: 'Bier',
        money_transaction_user_tags_name_start: 'conference:'
      ).result
      .select(
        'date_trunc(\'hour\', "transaction_items"."created_at") AS "hour"',
        'trim(leading \'conference:\' from "tags_users"."name") AS "conference"',
        'SUM("transaction_items"."quantity") AS "quantity"'
      ).group(
        '"hour"',
        '"conference"'
      ).order('"hour"')
      .to_sql
    ).values
  end
end
