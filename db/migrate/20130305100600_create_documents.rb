class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :user
      t.string :name
      t.string :referrer
      t.string :filename
      t.timestamps
    end
    add_index :documents, :user_id
  end
end
