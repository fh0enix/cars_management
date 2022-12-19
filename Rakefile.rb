require_relative 'admin\generate_car_db.rb'

  task :clear_whole_database do
    GenerateCarDb.new.cleer_db
  end

  task :add_one_new_record do
    GenerateCarDb.new.add_one_new_record
  end

  task :add_multiple_records do
    Rake::Task['ask_question'].invoke
  end

  task :ask_question do
    puts "Enter number of cars to be added: "
    get_input
  end

  task :add_records do
    GenerateCarDb.new.add_multiple_records(@number)
  end

  def get_input
    STDOUT.flush
    @number = STDIN.gets.chomp.to_i
    Rake::Task['add_records'].invoke
  end
