namespace :reports do
  task send_daily_purchases: :enviroment do
    Reports::SendDailyPurchases.call
  end
end
