require "./keyscheck"

class MyServer

  def initialize
    puts "initialize MyServer"
    puts "start keys check in a separate thread"
    KeysCheck.new
  end

  def gen
    
    letters = (0..25).collect { ('a'..'z').to_a[rand(26)] }
    numbers = (0..25).collect { rand(9) }
    my_key = numbers.zip(letters).flatten.join
    puts "Key generated"
    $keys_list['available'].push(my_key)
    $keys_time[my_key] = Time.now
    return my_key
  end

  def get
    
    if $keys_list['available'] != []
      $keys_list['available'].shuffle!
      my_key = $keys_list['available'].pop
      $keys_list['blocked'].push(my_key)
      $keys_time[my_key] = Time.now
      return my_key
    else
      return false
    end

  end

  def del(my_key)

    is_deleted = false

    if $keys_list['available'].include?(my_key)
      $keys_list['available'].delete(my_key)
      $keys_time.delete(my_key)
      is_deleted = true

    elsif $keys_list['blocked'].include?(my_key)
      $keys_list['blocked'].delete(my_key)
      $keys_time.delete(my_key)
      is_deleted = true
    end
    return is_deleted
  end

  def unblock(my_key)

    is_unblocked = false
    if $keys_list['blocked'].include?(my_key)
      $keys_list['blocked'].delete(my_key)
      $keys_list['available'].push(my_key)
      is_unblocked = true
    end
    return is_unblocked
  end

  def keepalive(my_key)

    is_alive = false
    if $keys_list['blocked'].include?(my_key)
      $keys_time[my_key] = Time.now
      is_alive = true
    end
    return is_alive
  end

end