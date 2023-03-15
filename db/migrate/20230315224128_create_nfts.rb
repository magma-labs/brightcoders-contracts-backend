class CreateNfts < ActiveRecord::Migration[7.0]
  def change
    create_table :nfts do |t|
      t.string :name
      t.text :description
      t.string :student

      t.timestamps
    end
  end
end
