When(/^the user "(.*?)" makes a "(.*?)"€ deposit$/) do |uname, amount|
  amount = amount.to_f * 100
  user = User.find_by_name(uname)
  deposit = JSON.generate(amount: amount.to_i)
  post(user_user_deposit_path(format: :json, user_id: user.id), deposit)
end

Then(/^the account of user "(.*?)" should be credited with "(.*?)"€$/) do |uname, amount|
  amount = amount.to_f * 100
  user = User.find_by_name(uname)
  expect(user.balance.to_f).to eq(amount)
end
