class NDArray
  attr_accessor :array
  def initialize(array = [])
    @array = array
  end

  def [](*args)
    return_array = array
    args.each do |num|
      return_array = return_array[num]
      break if return_array.nil?
    end
    return_array
  end
end
