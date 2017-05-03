class User < ActiveRecord::Base
  has_many :photos
  has_many :comments  

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    self.salt = "#{rand}"
    self.password_digest = Digest::SHA1.hexdigest("#{pwd}#{self.salt}")
  end

  def password_valid?(pwd)
    candidate_digest = Digest::SHA1.hexdigest("#{pwd}#{self.salt}")
    return candidate_digest == self.password_digest
  end

  def password_confirmation
    @password_confirmation
  end

  def password_confirmation=(pwd_confirm)
    @password_confirmation = pwd_confirm
  end
 

  def validate_login
    if login.nil?
      errors.add(:login, "cannot be empty")
    elsif !User.find_by(login: login).nil?
      errors.add(:login, "is already used")
    end
  end
  
  def validate_password_confirmation
    if password.nil? || password.empty?
      errors.add(:password, "cannot be empty")
    elsif password_confirmation.nil?
      errors.add(:password_confirmation, "cannot be empty")
    elsif password != password_confirmation
      errors.add(:password_confirmation, "should be same as password")
    end
  end
 
  validate :validate_login
  validate :validate_password_confirmation
end
