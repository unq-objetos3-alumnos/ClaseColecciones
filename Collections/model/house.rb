class House
  attr_accessor :direction, :ambients, :number

  def initialize direction, ambients, number
    @number = number
    @direction = direction
    @ambients = ambients
  end
end