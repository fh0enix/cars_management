class Statistic
  def initialize(user_data, stat)
    @stat = stat
    @user_data = user_data
  end

  def cleener
    @user_data = "make:#{@user_data[:make]} " +
                 "model:#{@user_data[:model]} " +
                 "year:#{@user_data[:year_from]}-#{@user_data[:year_to]} " +
                 "price:#{@user_data[:price_from]}-#{@user_data[:price_to]}"
    @user_data
  end

  def call
    if @stat.key?(cleener)
      @stat[@user_data] += 1
      File.open("./.db/st.yml", 'w') { |f| YAML.dump(@stat, f) }
    else
      @stat[@user_data] = 1
      File.open("./.db/st.yml", 'w') { |f| YAML.dump(@stat, f) }
    end
    @stat[@user_data]
  end
end
