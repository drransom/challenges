class ChangeMachine:
    def __init__(self, coins):
        self.coins = sorted(coins)
        self.coins.reverse()


    def ways_to_make_change(self, num, coin_idx = 0):
        if num < 0:
            return 0
        if num == 0:
            return 1
        else:
            sum = 0
            for coin_num in range(coin_idx, len(self.coins)):
                coin = self.coins[coin_num]
                if num >= coin:
                    sum += self.ways_to_make_change(num - coin, coin_num)
            return sum

machine = ChangeMachine([1, 2, 5, 10, 20, 50, 100, 200])
print machine.ways_to_make_change(200)
