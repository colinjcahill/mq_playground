def cc_sub(cc)
  cc = cc.split('')
  indices = []
  cc.map! do |num|
    if num == '*'
      indices << cc.index(num)
      num = 0
    else
      num = num.to_i
    end
  end
  return [cc.join, indices]
end

def luhn(code)
  s1 = s2 = 0
  code.to_s.reverse.chars.each_slice(2) do |odd, even|
    s1 += odd.to_i

    double = even.to_i * 2
    double -= 9 if double >= 10
    s2 += double
  end
  (s1 + s2) % 10 == 0
end


def guess_check(array)
  unless luhn(array.first)
    old_pan = array.first.split('')
    array.last.each do |index|
      0.upto(9).each do |i|
        old_pan[index] = i.to_s
        if luhn(old_pan)
          $pan = old_pan.join
          break
        end
      end
    end
  end
  return $pan || 'not found'
end



puts "Enter a partial PAN, substituting asterisks for any missing numbers.  Ex:  1234****4321****. OR, enter a full pan to check its Luhn's value."

input = STDIN.gets.chomp
while input.length != 16
  puts "\nPlease input a value of exactly 16 digits.\n"
  input = STDIN.gets.chomp
end

if input.include?('*')
  puts "\nThe lowest value for a Luhn's valid credit card number is #{guess_check(cc_sub(input))}\n"
else
  puts "\nLuhn\'s value is #{luhn(input).to_s.upcase}\n"
end
