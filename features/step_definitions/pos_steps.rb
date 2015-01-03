When(/^the code "(.*?)" is scanned$/) do |code|
  object = JSON.parse(get(identifier_path(id: code)).body)
  if @cart_id
    case object['type']
    when 'user'
      cart_update = JSON.generate({
        user_id: object['id']
      })
      cart = put(cart_path(id: @cart_id, format: :json), cart_update, {'CONTENT_TYPE' => 'application/json'})
      new_transaction = JSON.generate({
        cart_id: @cart_id
      })
      post(transactions_path(format: :json), new_transaction, {'CONTENT_TYPE' => 'application/json'})
    end
  else
    case object['type']
    when 'product'
      new_cart = JSON.generate({
        cart_items: [
          {quantity: 1, pricing_id: object['pricings'][0]['id']}
        ]
      })
      cart = JSON.parse(post(carts_path(format: :json), new_cart, {"CONTENT_TYPE" => "application/json"}).body)
      @cart_id = cart['id']
    end
  end
end

When(/^the POS is setup as anonymous$/) do
  @cart_id = nil
end
