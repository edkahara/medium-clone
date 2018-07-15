class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.integer :user_id
      t.string :banner_image
      t.string :file
      t.string :alt
      t.string :hint

      t.timestamps
    end
    add_index :stories, :slug, unique: true
    add_index :stories, :user_id
  end
end
