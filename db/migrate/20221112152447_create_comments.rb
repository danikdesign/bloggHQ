class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.text :author
      t.integer :post_id

      t.timestamps
    end
  end
end
