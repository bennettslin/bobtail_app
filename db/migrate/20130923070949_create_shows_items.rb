class CreateShowsItems < ActiveRecord::Migration
  def change
    create_table :shows_items do |t|
      t.string :name
      t.string :webpage
      t.string :city
      t.string :state
      t.string :extra
      t.datetime :date

      t.timestamps
    end
  end
end
