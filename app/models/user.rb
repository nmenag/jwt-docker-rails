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
  include Authenticable

  has_secure_password

  validates :email, :auth_token, presence: true, uniqueness: true
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/
end
