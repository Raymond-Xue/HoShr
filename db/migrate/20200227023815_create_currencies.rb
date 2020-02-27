class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :currency_name
      t.string :currency_symbol
      t.float :conversion_rate_to_usd

      t.timestamps
    end
  end
end
