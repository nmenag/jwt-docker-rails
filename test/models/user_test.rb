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
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user_one = users(:user_one)
  end

  test 'invalid without email' do
    @user_one.email = nil
    refute @user_one.valid?
  end

  test 'invalid without auth_token' do
    @user_one.auth_token = nil
    refute @user_one.valid?
  end
end
