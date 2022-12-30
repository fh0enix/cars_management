# frozen_string_literal: true

module AdvertPreprosessing
  VALID_ENG_LETTERS = /^[a-zA-Z\/\s]+$/

  def make
    puts I18n.t(:make)
    make_model_checker(I18n.t(:make), gets.strip)
  end

  def model
    puts I18n.t(:model)
    make_model_checker(I18n.t(:model), gets.strip)
  end

  def year
    puts I18n.t(:year)
    year_checker(gets.strip.to_i)
  end

  def odometer
    puts I18n.t(:odometer)
    zero_checker(I18n.t(:odometer), gets.strip.to_i)
  end

  def price
    puts I18n.t(:price)
    zero_checker(I18n.t(:price), gets.strip.to_i)
  end

  def description
    puts I18n.t(:description)
    description_checker(gets.strip)
  end

  def make_model_checker(name, data)
    @errors << I18n.t(:least_3_symbols_error, key: name.yellow.on_red) if data.size < 3
    @errors << I18n.t(:most_50_symbols_error, key: name.yellow.on_red) if data.size > 50
    @errors << I18n.t(:english_letters_error, key: name.yellow.on_red) unless valid_eng_letter(data)
    data
  end

  def valid_eng_letter(data)
    data =~ VALID_ENG_LETTERS
  end

  def zero_checker(name, data)
    @errors << I18n.t(:zero_error, key: name.yellow.on_red) if data.negative?
    data
  end

  def year_checker(data)
    @errors << I18n.t(:current_year_error) if data > Time.new.year
    @errors << I18n.t(:year_1900_error) if data <= 1900
    data
  end

  def description_checker(data)
    @errors << I18n.t(:description_error) if data.size > 5000
    data
  end
end
