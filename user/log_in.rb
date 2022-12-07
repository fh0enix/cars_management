# frozen_string_literal: true

require 'bcrypt'
require 'yaml'

@users_db = [{ email: 111_771, ggg: 33 }, { email: 1121, ggg: 303 }]
@user_auth = { email: 1111, ggg: 33 }

def a
  t = false
  @users_db.each do |user|
    next unless user[:email] == @user_auth[:email]

    t = true
  end
  t
end
