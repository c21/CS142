class AddSaltAndPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salt, :string
    add_column :users, :password_digest, :string
    User.reset_column_information
    User.all.each do |u|
      salt = "#{rand}"
      u.update_column(:salt, salt)
      # Existing user password equals to login.
      u.update_column(:password_digest, Digest::SHA1.hexdigest("#{u.login}#{salt}")) 
    end
  end
end
