class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :joined_at

      t.timestamps
    end
  end
end
