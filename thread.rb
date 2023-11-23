current_thread = 1  #визначає, який потік може виводити повідомлення

thread1 = Thread.new do
  10.times do |i|
    while current_thread != 1  # чекаємо, поки не настане черга потоку 1
      sleep 0.1
    end
    puts "Thread 1: #{i + 1}" # виводимо повідомлення потоком 1
    current_thread = 2 # змінюємо чергу на потік 2
  end
end

thread2 = Thread.new do
  10.times do |i|
    while current_thread != 2 # чекаємо, поки не настане черга потоку 2
      sleep 0.1
    end
    puts "Thread 2: #{i + 1}" # виводимо повідомлення потоком 2
    current_thread = 1  # змінюємо чергу на потік 1
  end
end
# очікуємо завершення обох потоків
thread1.join
thread2.join