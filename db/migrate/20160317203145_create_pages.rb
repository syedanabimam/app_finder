class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :search_id

      t.timestamps
    end
  end
end
