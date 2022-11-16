class Formatting
  def initialize(data, user_data)
    @data = data
    @result_data = user_data
    @make = []
    @model = []
  end

  def call
    if @result_data[:sort_direction] != 'asc'
      @result_data[:sort_direction] = 'desc'
    end

    if @result_data[:sort_option] != 'price'
      @result_data[:sort_option] = 'date_added'
    end

    @data.each do |car|
      @make << car[:make].upcase
      @model << car[:model].upcase
    end

    if @make.include?(@result_data[:make]) == false
     @result_data[:make] = 0
    end

    if @model.include?(@result_data[:model]) == false
      @result_data[:model] = 0
    end
    @result_data
  end
end
