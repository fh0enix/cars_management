# frozen_string_literal: true

require 'yaml'
require 'bcrypt'
require 'colorize'
require_relative 'user_menu'
require_relative '../admin/admin_menu'

class SignUp
  VALID_EMAIL = /^\w+([.-]?\w+){4,}@\w+([.-]?\w+)*(\.\w{2,})+$/
  VALID_PASS = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%\^&*]{2,}).{8,20}$/
  USERS_DB_PATH = './.db/users.yml'
  EMAIL_EXSIST = true

  def initialize
    @users_db = []
    @input_data = { email: nil, password: nil }
  end

  def call
    enter_email
    enter_password
    input_data_is_valid ? show_user_menu : show_error
  end

  private

  def enter_email
    puts I18n.t(:get_email)
    @input_data[:email] = gets.strip.to_s.downcase
  end

  def enter_password
    puts I18n.t(:get_password)
    @input_data[:password] = gets.strip.to_s
  end

  def valid_password?
    @input_data[:password] =~ VALID_PASS
  end

  def valid_email?
    @input_data[:email] =~ VALID_EMAIL
  end

  def show_error
    puts I18n.t(:invalid_email).red if @input_data[:email].nil?
    puts I18n.t(:invalid_password).red if @input_data[:password].nil?
    puts I18n.t(:email_exsist).red if @input_data[:email] == EMAIL_EXSIST
  end

  def input_data_is_valid
    @input_data[:email] = nil unless valid_email?
    @input_data[:password] = valid_password? ? crypt_password : nil

    !@input_data[:email].nil? &&
      !@input_data[:password].nil? &&
      user_is_absent
  end

  def crypt_password
    BCrypt::Password.create(@input_data[:password]).to_s
  end

  def check_db
    if File.exist?(USERS_DB_PATH)
      @users_db = YAML.load_file(USERS_DB_PATH)
    else
      File.write(USERS_DB_PATH, YAML.dump(@users_db))
    end
  end

  def add_user_to_db
    @users_db.push(@input_data)
    File.write(USERS_DB_PATH, YAML.dump(@users_db))
  end

  def show_user_menu
    add_user_to_db
    puts I18n.t(:hello_user).red.on_white +
         @input_data[:email].upcase.black.on_white

    user_is_admin? ? AdminMenu.new.run : UserMenu.new(@input_data[:email]).run
  end

  def user_is_admin?
    @users_db[0][:email] == @input_data[:email]
  end

  def user_is_absent
    check_db
    @users_db.find do |user|
      next unless user[:email] == @input_data[:email]

      @input_data[:email] = EMAIL_EXSIST
      return false
    end
    true
  end
end
