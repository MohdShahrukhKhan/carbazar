class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :review_id, null: false
      t.integer :user_id, null: false
      t.text :text, null: false
      t.integer :parent_comment_id, index: true  # To support replies

      t.timestamps
    end

    add_foreign_key :comments, :reviews
    add_foreign_key :comments, :comments, column: :parent_comment_id
    add_foreign_key :comments, :users
  end
end
