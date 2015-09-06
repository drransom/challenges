class NDArray
  attr_accessor :array
  def initialize(array = [])
    @array = array
  end

  def [](*args)
    return_value = array
    args.each_with_index do |num, idx|
      return_value = if num == :*
        retrieve_columns(return_value)
      else
        return_value[num]
      end
      break if return_value.nil?
      if idx < args.length - 1 &&
         !(return_value.is_a?(Array) || return_value.is_a?(NDArray))
        raise StandardError.new("number of indices passed exceeds array depth")
      end
    end
    return_value
  end

  def retrieve_columns(partial_array)
    partial_array.transpose
  end
end
