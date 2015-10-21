def convert_time_string(string)
  hours, minutes, seconds = string.scan(/\d\d?/).map { |i| i.to_i }
  pm = string.match(/PM/i)
  if pm
    hours += 12 if hours < 12
  else
    hours = 0 if hours == 12
  end
  [hours, minutes, seconds]
end

def add_leading_zero(str)
  str.length < 2 ? '0' + str : str
end
