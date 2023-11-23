# створюємо м'ютекс та умовну змінну для синхронізації
mutex = Mutex.new
condition_variable = ConditionVariable.new
turn = 1  #визначає, який потік може виводити повідомлення

thread1 = Thread.new do
  10.times do |i|
    mutex.synchronize do
      while turn != 1     # чекаємо, поки не настане черга потоку 1
        condition_variable.wait(mutex)
      end

      puts "Thread 1: #{i + 1}"   # виводимо повідомлення потоком 1

      # змінюємо чергу на потік 2 та повідомляємо його
      turn = 2
      condition_variable.signal
    end
  end
end

thread2 = Thread.new do
  10.times do |i|
    mutex.synchronize do
      while turn != 2   # чекаємо, поки не настане черга потоку 2
        condition_variable.wait(mutex)
      end

      puts "Thread 2: #{i + 1}"   # виводимо повідомлення потоком 2

      # змінюємо чергу на потік 1 та повідомляємо його
      turn = 1
      condition_variable.signal
    end
  end
end

# очікуємо завершення обох потоків
thread1.join
thread2.join