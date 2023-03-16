class CreateNfts < ActiveRecord::Migration[7.0]
  def change
    create_table :nfts do |t|
      t.string :name
      t.text :description
      t.string :student
      t.integer :token_id
      t.string :ipfs_metadata
      t.string :ipfs_image
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
