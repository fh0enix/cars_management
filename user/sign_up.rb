# frozen_string_literal: true

require 'yaml'
require 'bcrypt'
require 'colorize'
require_relative 'user_menu'

class SignUp
  VALID_EMAIL = /^\w+([.-]?\w+){4,}@\w+([.-]?\w+)*(\.\w{2,})+$/
  VALID_PASS = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%\^&*]{2,}).{8,20}$/
  USERS_DB_PATH = './.db/users.yml'
  EMAIL_EXSIST = true

  def initialize
    @users_db = []
    @user_data = { email: nil, password: nil }
  end

  def call
    enter_email
    enter_password
    user_data_is_valid ? show_user_menu : show_error
  end

  private

  def enter_email
    puts I18n.t(:get_email)
    @user_data[:email] = gets.strip.to_s.downcase
  end

  def enter_password
    puts I18n.t(:get_password)
    @user_data[:password] = gets.strip.to_s
  end

  def valid_password?
    @user_data[:password] =~ VALID_PASS
  end

  def valid_email?
    @user_data[:email] =~ VALID_EMAIL
  end

  def show_error
    puts I18n.t(:invalid_email).red if @user_data[:email].nil?
    puts I18n.t(:invalid_password).red if @user_data[:password].nil?
    puts I18n.t(:email_exsist).red if @user_data[:email] == EMAIL_EXSIST
  end

  def user_data_is_valid
    @user_data[:email] = nil unless valid_email?
    @user_data[:password] = valid_password? ? crypt_password : nil

    !@user_data[:email].nil? &&
      !@user_data[:password].nil? &&
      user_is_absent
  end

  def crypt_password
    BCrypt::Password.create(@user_data[:password]).to_s
  end

  def check_db
    if File.exist?(USERS_DB_PATH)
      @users_db = YAML.load_file(USERS_DB_PATH)
    else
      File.write(USERS_DB_PATH, YAML.dump(@users_db))
    end
  end

  def add_user_to_db
    @users_db.push(@user_data)
    File.write(USERS_DB_PATH, YAML.dump(@users_db))
  end

  def show_user_menu
    add_user_to_db
    puts I18n.t(:hello_user).red.on_white +
         @user_data[:email].upcase.black.on_white

    UserMenu.new.run
  end

  def user_is_absent
    check_db
    @users_db.find do |user|
      next unless user[:email] == @user_data[:email]

      @user_data[:email] = EMAIL_EXSIST
      return false
    end
    true
  end
end
