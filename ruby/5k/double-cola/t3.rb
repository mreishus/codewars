#!/usr/bin/env ruby

def answer(n)
  initial_queue = %i(Sheldon Leonard Penny Rajesh Howard)
  who_is_next(initial_queue, n)
end

def who_is_next(queue, goal)
  exp = 0
  l = queue.length
  step = 0
  index = 0

  loop do
    step_size = 2 ** exp
    step += step_size

    prev_index = index
    index = (index + 1) % l

    if step >= goal
      return queue[index - 1]
    elsif index <= prev_index
      exp += 1
    end
  end
end

#pp answer(1)
#pp answer(6)
#pp answer(9)
#pp answer(52)
#pp answer(7230702951)
