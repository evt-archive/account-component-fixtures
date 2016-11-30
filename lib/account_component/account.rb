module AccountComponent
  class Account
    include Schema::DataStructure

    attribute :id, String
    attribute :customer_id, String
    attribute :balance, Numeric, :default => 0
    attribute :held, Numeric, :default => 0
    attribute :opened_time, Time
    attribute :sequence, Numeric, :default => 0

    def open?
      !opened_time.nil?
    end

    def deposit(amount)
      self.balance += amount
    end

    def withdraw(amount)
      self.balance -= amount
    end

    def hold(amount)
      self.held += amount
    end

    def release(amount)
      self.held -= amount
    end

    def available_balance
      balance - held
    end

    def balance?(amount)
      balance >= amount
    end

    def available_balance?(amount)
      available_balance >= amount
    end

    def current?(other)
      return false if sequence.nil?

      if other.is_a? Numeric
        return self.sequence >= other
      else
        return self.sequence >= other.sequence
      end
    end
  end
end
