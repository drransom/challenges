int_eng_dict = {
  0: '',
  1: 'one',
  2: 'two',
  3: 'three',
  4: 'four',
  5: 'five',
  6: 'six',
  7: 'seven',
  8: 'eight',
  9: 'nine',
  10: 'ten',
  11: 'eleven',
  12: 'twelve',
  13: 'thirteen',
  14: 'fourteen',
  15: 'fifteen',
  16: 'sixteen',
  17: 'seventeen',
  18: 'eighteen',
  19: 'nineteen',
  20: 'twenty',
  30: 'thirty',
  40: 'forty',
  50: 'fifty',
  60: 'sixty',
  70: 'seventy',
  80: 'eighty',
  90: 'ninety',
  100: 'hundred',
  1000: 'thousand'
}

def number_to_english(num):
    if num > 1000:
        return 'not supported'
    elif num in int_eng_dict and (num < 100):
        return int_eng_dict[num]
    elif num > 20 and num < 100:
        return int_eng_dict[num - num % 10] + int_eng_dict[num % 10]
    elif num >= 100 and num < 1000:
        hundreds = int_eng_dict[num / 100] + int_eng_dict[100]
        if num % 100 == 0:
            tens =''
        else:
            tens = 'and' + number_to_english(num % 100)
        return hundreds + tens
    else:
        return 'onethousand'

def sum_english_numbers(max):
    sum = 0
    for i in range(max + 1):
        sum += len(number_to_english(i));
    return sum

print sum_english_numbers(1000)
