def missing_alphabets(s)
    
    account = {}
    s.split('').each do |ch|
      account[ch] ? account[ch] += 1 : account[ch] = 1
    end
    
    max = account.values.max
    
    missing_letters = ''
    ('a'..'z').each do |letter|
      if account[letter].nil? 
        missing_letters += letter * max
      elsif account[letter] < max
        missing_letters += letter * (max - account[letter])
      end
    end
        
    missing_letters
end
