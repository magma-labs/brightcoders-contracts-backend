class AddCourseToNfts < ActiveRecord::Migration[7.0]
  def change
    add_reference :nfts, :course, null: true, foreign_key: true
  end
end
