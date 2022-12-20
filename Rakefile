# frozen_string_literal: true

require_relative 'admin\generate_car_db'

desc 'Clear whole database'
task :clear_whole_database do
  GenerateCarDb.new.cleer_db
end

desc 'Add one new record'
task :add_one_new_record do
  GenerateCarDb.new.add_one_new_record
end

desc 'Add multiple records'
task :add_multiple_records do
  Rake::Task['ask_question'].invoke
end

desc 'Ask question'
task :ask_question do
  puts 'Enter number of cars to be added: '
  input
end

desc 'Add records'
task :add_records do
  GenerateCarDb.new.add_multiple_records(@number)
end

def input
  $stdout.flush
  @number = $stdin.gets.chomp.to_i
  Rake::Task['add_records'].invoke
end
