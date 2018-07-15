class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.integer :bookmarkable_id
      t.string :bookmarkable_type
      t.integer :user_id

      t.timestamps
    end
    add_index :bookmarks, :bookmarkable_id
    add_index :bookmarks, :bookmarkable_type
    add_index :bookmarks, :user_id
  end
end
