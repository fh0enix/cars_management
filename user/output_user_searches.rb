# frozen_string_literal: true

require 'yaml'

class OutputUserSearches < Output
  SEARCH_DB_PATH = './.db/searches.yml'
  SEARCH_FIELDS = %i[make model year_from year_to price_from price_to].freeze

  def initialize(user_id)
    @user_id = user_id
    @users_search = nil
  end

  def call
    user_made_search? ? show_search : show_error
  end

  private

  def user_made_search?
    return unless File.exist?(SEARCH_DB_PATH)

    @users_search = YAML.load_file(SEARCH_DB_PATH)
    @users_search.find { |search| search[:user].find { |user| user[:ID] == @user_id } }
  end

  def search_grouping
    @users_search.filter_map do |search|
      search[:user].filter_map do |user|
        next unless user[:ID] == @user_id
        search.slice(*SEARCH_FIELDS).merge(time: user[:time])
      end
    end.flatten
  end

  def show_search
    table = Terminal::Table.new do |t|
      search_grouping.each do |search|
        search.each { |row| t << row }
        t.add_separator
      end
      t.title = I18n.t(:my_searches_out).white.on_red
      t.style = TABLE_STYLES
    end
    puts table
  end

  def show_error
    puts I18n.t(:searches_do_not_exist).red.on_white
  end
end
