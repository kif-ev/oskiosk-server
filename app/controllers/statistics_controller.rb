class StatisticsController < ActionController::API
  def netdata
    expires_now # don't cache, don't generate e-tag
    render plain: format_for_netdata(consumption_since_start, "total_bought_items_since_start"), status: 200
  rescue Exception
    render plain: "ERROR", status: 500
  end

  private

  def format_for_netdata(data_points, type)
    return if data_points.blank?

    result = ""

    data_points.each do |row|
      result << "#{row[0]}_#{type}: #{row[1]}\n"
    end

    result
  end

  def consumption_since_start(product_criteria: {})
    ActiveRecord::Base.connection.execute(
      TransactionItem.ransack(
        {
          money_transaction_transaction_type_eq: 'cart_payment',
          money_transaction_user_tags_name_start: 'conference:'
        }.merge(product_criteria)
      ).result.
      select(
        'TRIM(LEADING \'conference:\' FROM "tags"."name") AS "conference"',
        'SUM("transaction_items"."quantity") AS "quantity"'
      ).group(
        '"conference"'
      ).to_sql
    ).values
  end
end
