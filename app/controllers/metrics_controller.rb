class MetricsController < ActionController::API
  before_action -> { doorkeeper_authorize! :metrics }

  def index
    expires_now
    render plain: prometheus_string, content_type: "text/plain; version=0.0.4"
  end

  private

  def prometheus_string
    products = Product.all.pluck(:id, :name)
    totals = TransactionItem.group(:product_id).sum(:quantity)

    metrics = "# HELP products_sold_total The total number of products sold\n"
    products.each do |id, name|
      metrics << "products_sold_total{product_id=\"#{id}\",product_name=\"#{name}\"} #{totals[id] || 0}\n"
    end

    metrics
  end
end
