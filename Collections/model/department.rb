require_relative '../model/house'
class Department < House
  attr_accessor :floor

  def initialize direction, ambients, floor, number
    @floor = floor
    super(direction,ambients,number)
  end
end