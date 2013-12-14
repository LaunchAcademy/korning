class NormalizeCustomers < ActiveRecord::Migration
  def up
    add_column :sales, :customer_id, :integer

    Sale.reset_column_information
    Sale.find_each do |sale|
      new_customer = format_customer(sale.attributes["customer_and_account_no"])
      customer = Customer.find_or_create_by(name: new_customer[0], account: new_customer[1])
      sale.customer_id = customer.id
      sale.save
    end

    remove_column :sales, :customer_and_account_no
  end

  def down
    add_column :sales, :customer_and_account_no, :string
    Sale.find_each do |sale|
      sale.update(customer_and_account_no:"#{sale.customer.name} #{sale.customer.account}")
      sale.save
    end
    Customer.delete_all
    remove_column :sales, :customer_id
  end

  def format_customer(string)
    string.gsub(/[()]/, ('')).split(' ')
  end

end
