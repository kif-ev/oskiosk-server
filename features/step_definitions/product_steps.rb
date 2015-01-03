Given(/^there are (\d+) items of a product "(.*?)" with the code "(.*?)"$/) do |quantity, name, code|
  create(:product, name: name, code: code, quantity: quantity)
end

Then(/^there should be only (\d+) "(.*?)" left$/) do |quantity, name|
  p = Product.find_by_name(name)
  expect(p.quantity).to eq(9)
end
