# frozen_string_literal: true

class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid, null: false, index: { unique: true }
      t.string :title, null: false
      t.boolean :published, null: false, default: true

      t.timestamps
    end
  end
end
