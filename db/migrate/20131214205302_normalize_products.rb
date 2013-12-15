class NormalizeProducts < ActiveRecord::Migration
  def up
    add_column :sales, :product_id, :integer

    Sale.reset_column_information
    Sale.find_each do |sale|
      new_product = sale.attributes["product_name"]
      product = Product.find_or_create_by(name: new_product)
      sale.product_id = product.id
      sale.save
    end

    remove_column :sales, :product_name
  end

  def down
    add_column :sales, :product_name, :string
    Sale.find_each do |sale|
      sale.update(product_name: sale.product.name)
      sale.save
    end
    Product.delete_all
    remove_column :sales, :product_id
  end

end
