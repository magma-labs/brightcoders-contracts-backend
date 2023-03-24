class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :surname
      t.string :second_surname
      t.string :email, unique: true
      t.string :wallet_address

      t.timestamps
    end
  end
end
