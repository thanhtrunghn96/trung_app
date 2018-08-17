# frozen_string_literal: true

class CreateAdvertisements < ActiveRecord::Migration[5.2]
  def change
    create_table :advertisements do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
