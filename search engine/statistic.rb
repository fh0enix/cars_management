class Statistic
  def initialize(user_data, results_car, stat)
    @stat = stat
    @results_car = results_car
    @user_data = user_data
    @id = ''
  end

  def delete_sort
    @user_data.delete(:sort_option)
    @user_data.delete(:sort_direction)
  end

  def id
    @id = "ID_#{@user_data[:make]}" +
                 "#{@user_data[:model]}" +
                 "#{@user_data[:year_from]}#{@user_data[:year_to]}" +
                 "#{@user_data[:price_from]}#{@user_data[:price_to]}"
    @id.to_sym
    @user_data[@id] = 1
    @id
  end

  def call
    delete_sort

    if File.exist?("./.db/searches.yml")
      @stat = YAML.load_file('./.db/searches.yml')
    else
      File.new("./.db/searches.yml", "w")
      @stat = [{SEARCHES: 'CAR'}]
    end

    if @stat.any? { |request| request.key?(id)}
      @stat.each do |request|
        if request.key?(@id)
          request[@id] += 1
          @user_data[@id] = request[@id]
        end
      end
    else
      @stat.push(@user_data)
    end

    File.open("./.db/searches.yml", 'w') { |f| YAML.dump(@stat, f) }

    @user_data[@id]
  end
end
