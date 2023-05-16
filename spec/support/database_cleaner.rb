RSpec.configure do |config|
  # add below the table name for excepting when the database to be clean
  static_info_tables = %w[]

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation, except: static_info_tables
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
