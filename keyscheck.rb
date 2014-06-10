
class KeysCheck

  def initialize

    Thread.new do 
      while true do
        check_blocked
        check_keepalive
        sleep 1
      end
    end
  end

  def check_blocked

    if $keys_list['blocked'] != []

      $keys_list['blocked'].each do |my_key|

        if Time.now - $keys_time[my_key] >= 60.00
          $keys_list['blocked'].delete(my_key)
          $keys_list['available'].push(my_key)
          $keys_time[my_key] = Time.now
        end
      end
    end
  end

  def check_keepalive

    if $keys_list['available'] != []

      $keys_list['available'].each do |my_key|

        if Time.now - $keys_time[my_key] >= 300.00
          $keys_list['available'].delete(my_key)
          $keys_time.delete(my_key)
        end

      end
    end
  end

end