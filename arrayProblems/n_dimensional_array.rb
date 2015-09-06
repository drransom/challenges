class NDArray
  attr_accessor :array
  def initialize(array = [])
    @array = array
  end

  def [](*args)
    indices = (args.length == 1 && args[0].is_a?(Array)) ? args[0] : args
    return_value = array
    indices.each_with_index do |num, idx|
      return_value = if num == :*
        retrieve_columns(return_value)
      else
        return_value[num]
      end
      break if return_value.nil?
      if idx < indices.length - 1 &&
         !(return_value.is_a?(Array) || return_value.is_a?(NDArray))
        raise StandardError.new("number of indices passed exceeds array depth")
      end
    end
    return_value
  end

  def []=(*args)
    indices = args[0...-2]
    subarray = self[indices]
    subarray[args[-2]] = args[-1]
  end

  def retrieve_columns(partial_array)
    partial_array.transpose
  end

  def to_s
    array.to_s
  end
end
