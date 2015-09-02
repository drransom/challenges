class Solution:
    # @param A : tuple of integers
    # @return a strings
    # @produces: largest number that can be produced by concatinating the
    # numbers in any order
    def largestNumber(self, A):
        strings = map(lambda x: str(x), A)
        strings.sort(cmp=lambda x, y: self.lexCompare(x, y), reverse=True)
        output = ''.join(strings)
        if output[0] == '0':
            return '0'
        else:
            return output


    def lexCompare(self, str1, str2):
        if str1 == str2:
            return 0
        elif str1 + str2 > str2 + str1:
            return 1
        else:
            return -1
