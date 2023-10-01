# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
      t.index :uid, unique: true
      t.index :email, unique: true
    end
  end
end
