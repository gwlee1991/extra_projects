require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  map = HashMap.new 
  chars = string.chars
  chars.each do |char|
    if map.include?(char)
      map[char] += 1
    else
      map[char] = 1
    end
  end
  count = 0
  map.each do |k, v|
    if v == 1
      count += 1
      if count > 1
        return false
      end
    end
  end
  true
end
