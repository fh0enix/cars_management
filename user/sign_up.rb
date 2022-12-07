# frozen_string_literal: true

require 'yaml'
require 'bcrypt'
require 'colorize'
require_relative 'user_menu'

class SignUp
  VALID_EMAIL = /^\w+([.-]?\w+){4,}@\w+([.-]?\w+)*(\.\w{2,})+$/
  VALID_PASS = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%\^&*]{2,}).{8,20}$/
  USERS_DB_PATH = './.db/users.yml'

  def initialize
    @users_db = []
    @user_auth = { email: nil, password: nil }
  end

  def call
    enter_email
    enter_password
    @user_auth[:email] = nil unless valid_email?(@user_auth[:email])
    valid_password?(@user_auth[:password]) ? crypt_password : @user_auth[:password] = nil
    check_errors
    add_user_to_db if user_data_is_valid?
  end

  private

  def enter_email
    puts I18n.t(:get_email)
    @user_auth[:email] = gets.strip.to_s
  end

  def enter_password
    puts I18n.t(:get_password)
    @user_auth[:password] = gets.strip.to_s
  end

  def valid_password?(password)
    password =~ VALID_PASS
  end

  def valid_email?(email)
    email =~ VALID_EMAIL
  end

  def check_errors
    puts I18n.t(:invalid_email).red if @user_auth[:email].nil?
    puts I18n.t(:invalid_password).red if @user_auth[:password].nil?
    puts I18n.t(:email_exsist).red if email_exsist
  end

  def user_data_is_valid?
    !@user_auth[:email].nil? || !@user_auth[:password].nil?
  end

  def crypt_password
    @user_auth[:password] = BCrypt::Password.create(@user_auth[:password]).to_s
  end

  def check_db
    if File.exist?(USERS_DB_PATH)
      @users_db = YAML.load_file(USERS_DB_PATH)
    else
      File.write(USERS_DB_PATH, YAML.dump(@users_db))
    end
  end

  def add_user_to_db
    @users_db.push(@user_auth)
    File.write(USERS_DB_PATH, YAML.dump(@users_db))

    puts I18n.t(:hello_user).red.on_white +
         @user_auth[:email].upcase.black.on_white

    UserMenu.new(@user_auth).run
  end

  def email_exsist
    check_db
    exsist = false
    @users_db.each do |user|
      next unless user[:email] == @user_auth[:email]

      @user_auth[:email] = nil
      exsist = true
    end
    exsist
  end
end
