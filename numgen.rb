#! /usr/bin/env ruby
# encoding: utf-8

# Created by Andrew Bednoff (AndrCmdr)
# E-mail: andrew.bednoff@yandex.com
# 2015-05-24@04:20:33

$num_classes = {
    "000000000" => [],
    "100000000" => [],
    "010000000" => [],
    "200000000" => [],
    "001000000" => [],
    "110000000" => [],
    "000100000" => [],
    "300000000" => [],
    "020000000" => [],
    "101000000" => [],
    "000010000" => [],
    "210000000" => [],
    "100100000" => [],
    "011000000" => [],
    "000001000" => [],
    "400000000" => [],
    "201000000" => [],
    "120000000" => [],
    "100010000" => [],
    "010100000" => [],
    "002000000" => [],
    "000000100" => [],
    "310000000" => [],
    "200100000" => [],
    "111000000" => [],
    "100001000" => [],
    "030000000" => [],
    "010010000" => [],
    "001100000" => [],
    "000000010" => [],
    "500000000" => [],
    "301000000" => [],
    "220000000" => [],
    "200010000" => [],
    "110100000" => [],
    "021000000" => [],
    "102000000" => [],
    "100000100" => [],
    "010001000" => [],
    "001010000" => [],
    "000200000" => [],
    "000000001" => []
}

$num_classes["exceptions"] = {}
# $num_classes["exceptions"] = {"111111111" => ["0123456789", "1234567890", "123456789"]}
# $num_classes["exceptions"] = {"111111111" => ["0123456789", "1234567890", "123456789"], "000000000" => ["0123456789", "1234567890", "123456789"]}

def nums(range)
    digits = []
    equal_digits = []
    num_class = ""
    for num in range
        digits = Array.new(10, 0)
        for phase1 in 1..num.to_s.length-1
            digits[num.to_s[phase1].to_i]+=1
        end
        equal_digits = Array.new(11, 0) # 11
        for phase2 in 0..9
            if digits[phase2] > 1
                equal_digits[digits[phase2]]+=1
            end
        end
        # custom join
        num_class = ""
        for phase3 in 2..equal_digits.length-1
            num_class += equal_digits[phase3].to_s
        end
#       print num.to_s[1..num.to_s.length-1], "\n"
#       print digits.to_s, "\n"
#       print equal_digits.to_s, "\n"
#       print num_class, "\n\n"
        if $num_classes.has_key?(num_class)
            $num_classes[num_class] << num.to_s[1..num.to_s.length-1]
        else
            if $num_classes["exceptions"].has_key?(num_class)
                $num_classes["exceptions"][num_class] << num.to_s[1..num.to_s.length-1]
            else
                $num_classes["exceptions"][num_class] = [num.to_s[1..num.to_s.length-1]]
            end
        end
    end
end

# nums(1000..2000-1)
nums(1000000..2000000-1)

key_str = ""
for key, val in $num_classes
    if key == "exceptions"
        print key, ":\n" # otherwise, printing raw keys
    else
        # custom decode number class (key) & custom join with injection
        key_str = ""
        for unit in 0..key.length-1
            if key[unit].to_i != 0
                key_str += ((unit+2).to_s + "+") * key[unit].to_i # +2 shift
            end
        end
        if key_str == ""
            key_str = "0+"
        end
        print key_str.chomp!("+"), ":\n" # -1 "+" char at the end
        # print key_str[0..key_str.length-2], ":\n" # -1 "+" char at the end
    end
    if val.class.to_s == "Array"
        for unit in val
            print unit.to_s, "\n"
        end
    elsif val.class.to_s == "Hash"
        print val.to_s, "\n"
    else
        print val.to_s, "\n"
    end
    print "\n"
end
