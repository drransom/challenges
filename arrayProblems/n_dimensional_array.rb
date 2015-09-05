class NDArray
  attr_accessor :array
  def initialize(array = [])
    @array = array
  end

  def [](*args)
    return_value = array
    args.each do |num|
      return_value = return_value[num]
      break unless return_value.is_a?(Array) || return_value.is_a?(NDArray)
    end
    return_value
  end
end
