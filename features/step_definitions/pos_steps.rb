When(/^the code "(.*?)" is scanned$/) do |code|
  object = JSON.parse(get(identifier_path(id: code)).body)
  if @cart_id
    case object['type']
    when 'user'
      cart_update = JSON.generate({
        user_id: object['id']
      })
      cart = put(cart_path(id: @cart_id, format: :json), cart_update)
      post(cart_cart_payment_path(cart_id: @cart_id, format: :json))
    when 'product'
      p_id = object['pricings'][0]['id']
      cart = JSON.parse(get(cart_path(id: @cart_id, format: :json)).body)
      cart_items = cart['cart_items']
      ci_index = cart_items.index {|ci| ci['pricing_id'] == p_id.to_i}
      if ci_index
        cart_items[ci_index]['quantity'] += 1
      else
        cart_items << {pricing_id: p_id, quantity: 1}
      end
      cart_update = JSON.generate({cart_items: cart_items})
      cart = patch(cart_path(id: @cart_id, format: :json), cart_update)
      @errors << cart.status unless cart.successful?
    end
  else
    case object['type']
    when 'product'
      new_cart = JSON.generate({
        cart_items: [
          {quantity: 1, pricing_id: object['pricings'][0]['id']}
        ]
      })
      cart = JSON.parse(post(carts_path(format: :json), new_cart).body)
      @cart_id = cart['id']
    end
  end
end

Given(/^there is a POS$/) do
  @bearer_token = create(:oauth_token, scopes: 'public checkout deposit').token
  header 'Authorization', "Bearer #{@bearer_token}"
  header 'Content-Type', 'application/json'
  @cart_id = nil
  @errors = []
end

When(/^the POS is setup as anonymous$/) do
  @bearer_token = create(:oauth_token, scopes: 'public checkout deposit').token
  header 'Authorization', "Bearer #{@bearer_token}"
  header 'Content-Type', 'application/json'
  @cart_id = nil
  @errors = []
end

Then(/^there should be an error$/) do
  expect(@errors).not_to be_empty
end
