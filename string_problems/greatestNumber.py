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
        # if len(str1) == len(str2):
        #     if str1 == str2:
        #         return 0
        #     elif str1 > str2:
        #         return 1
        #     else:
        #         return -1
        # elif len(str1) > 0 and len(str1) < len(str2):
        #     substring = str2[:len(str1)]
        #     if substring == str1:
        #         return self.lexCompare(str1, str2[len(str1):])
        #     else:
        #         return self.lexCompare(str1, substring)
        # elif len(str2) > 0 and len(str1) > len(str2):
        #     substring = str1[:len(str2)]
        #     if substring == str2:
        #         return self.lexCompare(str1[len(str2):], str2)
        #     else:
        #         return self.lexCompare(substring, str2)
        # elif str1 == '':
        #     return 1
        # else:
        #     return -1

x = Solution()
print x.largestNumber([ 472, 663, 964, 722, 485, 852, 635, 4, 368, 676, 319, 412 ])
