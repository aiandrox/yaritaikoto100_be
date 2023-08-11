# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :list, null: false, foreign_key: true
      t.integer :number, null: false
      t.string :name, null: false
      t.datetime :done_at

      t.timestamps
    end
  end
end
