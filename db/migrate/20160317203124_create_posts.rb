class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :search_id

      t.timestamps
    end
  end
end
