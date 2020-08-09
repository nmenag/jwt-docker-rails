require 'test_helper'

class WebTokenTest < ActiveSupport::TestCase
  include Authenticable

  test '#decode' do
    token = 'eyJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6IjI2ZjliN2FlOGNkMDBjZjQiLCJleHAiOjE1OTY5NDAxMjZ9.ZA1tl0Ydu4ejgJnv4-LlcoOHGc5SiZnh1m0OygpUWM0'
    resp = Authenticable::WebToken.decode(token)
    assert_equal resp, [{"token"=>"26f9b7ae8cd00cf4", "exp"=>1596940126}, {"alg"=>"HS256"}]
  end
end