class AddOrderNumToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :order_num, :integer
  end
end
