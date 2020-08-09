# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  auth_token      :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  active          :boolean          default(FALSE)
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  validates :email, :auth_token, presence: true, uniqueness: true
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/

  before_validation :assign_auth_token


  def web_token
    WebToken.encode({ token: self.auth_token })
  end

  def update_auth_token
    assign_auth_token
    save!
  end

  private

  def assign_auth_token
    if self.auth_token.blank?
      begin
        self.auth_token = SecureRandom.hex(8)
      end while User.find_by(auth_token:  self.auth_token)
    end
  end
end
