import random
import pdb
class SortArray(list):

    def mergeSort(self):
        if len(self) <= 1:
            return self
        else:
            mid = len(self) / 2
            left = SortArray(self[:mid])
            right = SortArray(self[mid:])
            return SortArray.merge(left.mergeSort(), right.mergeSort())

    def quicksort_in_place(self, options = {}):
        # pdb.set_trace()
        start = options['start'] if options.has_key('start') else 0
        end = options['end'] if options.has_key('end') else len(self) - 1
        if options.has_key('map_function'):
            map_function = options['map_function']
        else:
            map_function = lambda x: x
        if len(self) <= 1 or start >= end:
            return
        if start >= end:
            return
        # self.move_pivot_to_start(start, end)
        mid = self.partition(start, end, map_function)
        if start < mid:
            options = {'start': start, 'end': mid - 1, 'map_function': map_function}
            self.quicksort_in_place(options)
        if mid < end:
            options = {'start': mid+1, 'end': end, 'map_function': map_function}
            self.quicksort_in_place(options)

    def partition(self, start, end, map_function):
        left_index = start + 1
        right_index = end
        pivot_value = map_function(self[start])
        while right_index >= left_index:
            if (map_function(self[left_index]) > pivot_value and
               map_function(self[right_index]) <= pivot_value):
                self.swap(left_index, right_index)
            if map_function(self[right_index]) > pivot_value:
                right_index -= 1
            if map_function(self[left_index]) <= pivot_value:
                left_index += 1
        if map_function(self[start]) > map_function(self[right_index]):
            self.swap(start, right_index)
        return right_index


    def move_pivot_to_start(self, start, end):

        rand_num = random.random()
        if rand_num == 1:
            self.move_pivot_to_start(start, end)
        else:
            index = int(rand_num * (end - start) + start)
            self.swap(start, index)

    def swap(self, idx1, idx2):
        temp = self[idx1]
        self[idx1] = self[idx2]
        self[idx2] = temp

    @classmethod
    def merge(cls, sortArray1, sortArray2):
        new = []
        while len(sortArray1) > 0 and len(sortArray2) > 0:
            if sortArray1[0] < sortArray2[0]:
                new.append(sortArray1.pop(0))
            else:
                new.append(sortArray2.pop(0))
        return new + sortArray1 + sortArray2
