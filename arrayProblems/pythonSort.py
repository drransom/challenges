class SortArray(list):

    def mergeSort(self):
        if len(self) <= 1:
            return self
        else:
            mid = len(self) / 2
            left = SortArray(self[:mid])
            right = SortArray(self[mid:])
            return SortArray.merge(left.mergeSort(), right.mergeSort())

    @classmethod
    def merge(cls, sortArray1, sortArray2):
        new = []
        while len(sortArray1) > 0 and len(sortArray2) > 0:
            if sortArray1[0] < sortArray2[0]:
                new.append(sortArray1.pop(0))
            else:
                new.append(sortArray2.pop(0))
        return new + sortArray1 + sortArray2


x = SortArray([1, 5, 3])
print x.mergeSort()
