class AddUseridToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :user_id, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_index :products, [:user_id]
  end
end
