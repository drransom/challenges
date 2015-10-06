class RGBSorter(list):

    def rgbSort(self):
        if len(self) <= 1:
            return self
        low_index = 0
        for letter in ['R', 'G']:
            low_index = self.find_next(low_index, letter)
            high_index = low_index + 1
            while high_index < len(self) and low_index >= 0:
                if self[high_index] == letter:
                    self.swap(low_index, high_index)
                    low_index = self.find_next(low_index + 1, letter)
                    high_index = low_index + 1
                else:
                    high_index += 1
        return self


    def find_next(self, start_index, target_value):
        for index in range(start_index, len(self)):
            if self[index] != target_value:
                return index
        return -1

    def swap(self, index1, index2):
        temp = self[index1]
        self[index1] = self[index2]
        self[index2] = temp
