class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :employee_name_email
      t.string :customer_and_account_no
      t.string :product_name
      t.date :sale_date
      t.decimal :sale_amount
      t.integer :units_sold
      t.string :invoice_no
      t.string :invoice_frequency

      t.timestamps
    end
  end
end
