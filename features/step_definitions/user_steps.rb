Given(/^there is a user "(.*?)" with the code "(.*?)"$/) do |name, code|
  create(:user, name: name, code: code)
end

Then(/^the price of (\d+) "(.*?)" should be debited from the account of "(.*?)"$/) do |quantity, pname, uname|
  product = Product.find_by_name(pname)
  user = User.find_by_name(uname)
  pricing = product.pricings.order(:price).first
  expect(user.balance).to eq(- pricing.price * quantity.to_i)
end
