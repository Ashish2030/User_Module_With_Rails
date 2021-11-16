class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.bigint :mobile
      t.string :email
      t.string :hashed_password

      t.timestamps
    end
  end
end
