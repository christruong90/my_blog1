class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.text :email
      t.text :name
      t.text :subject
      t.text :message

      t.timestamps null: false
    end
  end
end
