class AddLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    User.reset_column_information
    User.all.each do |u|
      u.update_column(:login, u.last_name.downcase)
    end
  end
end
