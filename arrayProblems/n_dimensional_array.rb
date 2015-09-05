class NDArray
  attr_accessor :array
  def initialize(array = [])
    @array = array
  end

  def [](*args)
    return_value = array
    args.each_with_index do |num, idx|
      return_value = return_value[num]
      break if return_value.nil?
      if idx < args.length - 1 && !(args.is_a?(Array) || args.is_a?(NDArray))
        raise StandardError.new("number of indices passed exceeds array depth")
      end
    end
    return_value
  end
end
