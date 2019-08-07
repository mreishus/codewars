#!/usr/bin/env ruby

def max_ball(v)
  time = 0.0
  last_height = 0
  increment = 0.1
  while true do
    time += increment
    this_height = height(v, time)
    if this_height < last_height
      return ((time - increment) * 10).round
    end
    last_height = this_height
  end
  
end

def height(v_km_h, t)
  v_km_s = v_km_h.to_f / (60 * 60).to_f
  v_m_s = v_km_s.to_f * (1000.0)
  g = 9.81
  h = v_m_s*t - (0.5*g*t*t)
  return h
end

puts max_ball(15)
puts max_ball(25)
puts max_ball(37)


#h = v*t - 0.5*g*t*t
#    (m/s) * s      m/s^2 * s * s
#        m                  m
