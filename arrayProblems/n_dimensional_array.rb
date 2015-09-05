class NDArray
  attr_accessor :array
  def initialize(array = [])
    @array = array
  end

  def [](idx)
    array[idx]
  end
end
