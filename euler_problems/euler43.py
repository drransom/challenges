import sys

def is_pandigital(n):
    string_arr = list(str(n))
    string_arr.sort()
    return string_arr == ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

def pandigital_property_sum():
    sum = 0
    num = int(10 ** 9)
    while num < (10 ** 10):
        if (num == int(10 ** 9)):
            print "number is really 10^9"
            sys.stdout.flush()
        if (num % (10 ** 9)) == 0:
            print num
            sys.stdout.flush()
        if is_pandigital(num) and meets_condition(num):
            sum += num
        num += 1
    return sum

def generate_all_permutations(array, start = 0):
    #assumes elements are unique
        print array
    for i in range(start+1, len(array)):
        swap(array, start, i)
        generate_all_permutations(array, start+1)


def swap(array, i, j):
    temp = array[j]
    array[j] = array[i]
    array[i] = temp

def meets_condition(num):
    print "checking pandigitality of %s" %(num)
    string_num = str(num)
    if int(string_num[1:4]) % 2 != 0:
        return False
    elif int(string_num[2:5]) % 3 != 0:
        return False
    elif int(string_num[3:6]) % 5 != 0:
        return False
    elif int(string_num[4:7] % 7) != 0:
        return False
    elif int(string_num[5:8]) % 11 != 0:
        return False
    elif int(string_num[6:9]) % 13 != 0:
        return False
    elif int(string_num[7:10]) % 17 != 0:
        return False
    else:
        return True

# print pandigital_property_sum()

generate_all_permutations([1, 2, 3])
