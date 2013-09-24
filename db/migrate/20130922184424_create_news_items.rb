class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :heading
      t.text :entry

      t.timestamps
    end
  end
end
