class AddAdminNameToNewsItems < ActiveRecord::Migration
  def change
    add_column :news_items, :admin_name, :string
  end
end
