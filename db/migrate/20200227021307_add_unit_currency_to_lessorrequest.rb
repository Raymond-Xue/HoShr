class AddUnitCurrencyToLessorrequest < ActiveRecord::Migration[6.0]
  def change
	add_column :lessor_requests, :total_rent_unit, :integer
	add_column :lessor_requests, :min_duration_unit, :integer
	change_column :lessor_requests, :total_rent_currency, :integer, using: 'total_rent_currency::integer'
  end
end
