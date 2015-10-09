def move_zeroes(nums)
    ZeroCounter.new(nums).move_zeroes
end

class ZeroCounter
    attr_accessor :array
    def initialize(array)
        @array = array
    end

    def count_zeroes
        array.inject(0) { |memo, num| memo += num === 0 ? 1 : 0 }
    end

    def move_zeroes
        num_zeroes = count_zeroes
        if count_zeroes > 0 && count_zeroes < array.length
            move_zeroes_to_back(count_zeroes)
        end
    end

    def move_zeroes_to_back(count_zeroes)
        first_zero, last_non_zero = find_first_and_last
        while first_zero < last_non_zero do
            bubble_zero_back(first_zero, last_non_zero)
            while first_zero < array.length - count_zeroes && array[first_zero] != 0 do
                first_zero += 1
            end
            while last_non_zero > 0 && array[last_non_zero] == 0 do
                last_non_zero -= 1
            end
        end
    end

    def bubble_zero_back(zero_idx, last_non_zero_idx)
        (zero_idx...last_non_zero_idx).each do |idx|
            array[idx], array[idx + 1] = array[idx + 1], array[idx]
        end
    end


    def find_first_and_last(end_idx = array.length - 1)
        last_non_zero = end_idx
        last_non_zero -= 1 while array[last_non_zero] == 0
        [array.index(0), last_non_zero]
    end

end
