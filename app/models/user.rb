class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { message: "must be unique", case_sensitive: false }
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
  
    @user = User.find_by(email: email.strip.downcase).try(:authenticate, password)
    
    if @user
      @user
    else
      nil
    end
  
  end

end
