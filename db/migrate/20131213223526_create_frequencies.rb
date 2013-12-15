class CreateFrequencies < ActiveRecord::Migration
  def change
    create_table :frequencies do |t|
      t.string :frequency

      t.timestamps
    end
  end
end
