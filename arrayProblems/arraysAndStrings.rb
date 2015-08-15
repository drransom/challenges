class String
  def is_permutation?(other_string)
    return false unless self.length == other_string.length
    this_count = count_chars(self)
    this_count == count_chars(other_string)
  end

  def replace_spaces
    self.gsub(' ', '%20')
  end

  def basic_compression
    new_str_arr = []
    self.length.times do |idx|
      char = self[idx]
      if new_str_arr[-2] == char
        new_str_arr[-1] += 1
      else
        new_str_arr << char
        new_str_arr << 1
      end
    end
    self.length < new_str_arr.length ? self : new_str_arr.join
  end

private

  def count_chars(str)
    output = Hash.new(0)
    str.each_char do |char|
      output[char] += 1
    end
    output
  end
end

class Array
  #assumes self is NxN
  # def rotate_90_degrees!
  #   n = self.length
  #   halfway_point = n / 2
  #   (0..halfway_point).each do |ycoord|
  #     (0...halfway_point).each do |xcoord|
  #       rotate_clockwise!(xcoord, ycoord)
  #     end
  #   end
  #   (0...halfway_point).each do |ycoord|
  #     (0..halfway_point).each do |xcoord|
  #       flip_point_along_diagonal!(xcoord, ycoord)
  #     end
  #   end
  #   (halfway_point...self.length).each do |ycoord|
  #     (0..halfway_point).each do |xcoord|
  #       rotate_clockwise!(xcoord, ycoord)
  #     end
  #   end
  #   # (halfway_point...self.length).each do |ycoord|
  #   #   (halfway_point...self.length).each do |xcoord|
  #   #     roatate_90_degrees!(xcoord, ycoord)
  #   #   end
  #   # end
  # end
  #
  # def rotate_clockwise!(xcoord, ycoord)
  #   new_x, new_y = calculate_90_degree_point(xcoord, ycoord)
  #   flip_points!(xcoord, ycoord, new_x, new_y)
  # end
  #
  #
  # def flip_point_along_diagonal!(xcoord, ycoord)
  #   new_x, new_y = calculate_opposite_point(xcoord, ycoord)
  #   flip_points!(xcoord, ycoord, new_x, new_y)
  # end
  #
  # def calculate_90_degree_point(xcoord, ycoord)
  #   n = self.length
  #   if xcoord == ycoord || xcoord + ycoord == n-1
  #     calculate_rotation_from_diagonal(xcoord, ycoord)
  #   else
  #     old_y = ycoord
  #     ycoord = xcoord
  #     xcoord = self.length - old_y - 1
  #     [xcoord, ycoord]
  #   end
  # end
  #
  # def calculate_opposite_point(xcoord, ycoord)
  #   [self.length - ycoord - 1, self.length - xcoord - 1]
  # end
  #
  # def calculate_rotation_from_diagonal(xcoord, ycoord)
  #   if xcoord == ycoord
  #     [self.length - ycoord - 1, ycoord]
  #   else
  #     [self.length - xcoord -  1, xcoord]
  #   end
  # end
  #
  # def flip_points!(xcoord, ycoord, new_x, new_y)
  #   temp = self[new_y][new_x]
  #   self[new_y][new_x] = self[ycoord][xcoord]
  #   self[ycoord][xcoord] = temp
  # end

end
