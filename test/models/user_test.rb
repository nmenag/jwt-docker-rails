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
  setup do
    @user_one = users(:user_one)
  end

  test 'invalid without email' do
    @user_one.email = nil
    refute @user_one.valid?
  end

  test 'invalid with email format' do
    @user_one.email = 'wrongemail'
    refute @user_one.valid?
  end

  test 'valid  email format' do
    @user_one.email = 'example@example.com'
    assert @user_one.valid?
  end
end
