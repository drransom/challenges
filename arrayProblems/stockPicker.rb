def max_profit_with_two_transactions(prices)
    best = Transaction.new(0, 0, prices)
    second_best = Transaction.new(0, 0, prices)
    current_lowest_date = 0
    prices.each_with_index do |price, idx|
        current_transaction = Transaction.new(current_lowest_date, idx, prices)
        
        if current_transaction.profit > second_best.profit
            new_transaction = calculate_best_transaction(best, second_best, prices)
            best = new_transaction.profit > current_transaction.profit ? new_transaction : current_transaction
            second_best = new_transaction.profit <= current_transaction.profit ? new_transaction : current_transaction
            current_lowest_date = idx
            puts "best is #{best}"
            puts "second best is #{second_best}"
        elsif current_transaction.profit < 0
            current_lowest_date = idx
        end
    end
    best.profit + second_best.profit
end

class Transaction
    attr_accessor :buy_date, :sell_date, :profit, :buy_price, :sell_price
    def initialize(buy_date, sell_date, prices)
        @buy_date = buy_date
        @sell_date = sell_date
        @buy_price = prices[buy_date]
        @sell_price = prices[sell_date]
        @profit = sell_price - buy_price
    end
    def earlier?(other)
        buy_date <= other.buy_date
    end

    def to_s
      "buy date: #{buy_date}, sell date: #{sell_date}, " +
      "buy price: #{buy_price}, sell price: #{sell_price}, " +
      "profit: #{profit}"
    end
end

def calculate_best_transaction(transaction1, transaction2, prices)
    if transaction1.earlier?(transaction2)
        new_transaction = Transaction.new(transaction1.buy_date, transaction2.sell_date, prices)
    else
        new_transaction = Transaction.new(transaction2.buy_date, transaction1.sell_date, prices)
    end
    sorted = [transaction1, transaction2, new_transaction].sort do |t1, t2|
        if t1.profit > t2.profit
            1
        elsif t2.profit > t1.profit
            -1
        elsif t1.buy_price > t2.buy_price
            1
        elsif t2.buy_price > t1.buy_price
            -1
        elsif t1.earlier?(t2)
            1
        elsif t2.earlier?(t1)
            -1
        else
            0
        end
    end
    sorted.reverse[0]
end
