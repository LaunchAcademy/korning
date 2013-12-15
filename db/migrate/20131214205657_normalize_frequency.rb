class NormalizeFrequency < ActiveRecord::Migration
  def up
    add_column :sales, :frequency_id, :integer

    Sale.reset_column_information
    Sale.find_each do |sale|
      new_frequency = sale.attributes["invoice_frequency"]
      frequency = Frequency.find_or_create_by(frequency: new_frequency)
      sale.frequency_id = frequency.id
      sale.save
    end

    remove_column :sales, :invoice_frequency
  end

  def down
    add_column :sales, :invoice_frequency, :string
    Sale.find_each do |sale|
      sale.update(invoice_frequency: sale.frequency.frequency)
      sale.save
    end
    Frequency.delete_all
    remove_column :sales, :frequency_id
  end
end
