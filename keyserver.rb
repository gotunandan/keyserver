require './myserver'

class KeyServer < Sinatra::Application

  my_server = MyServer.new

  get '/gen' do
    my_key = my_server.gen
    if my_key
      "Key generated successfully #{my_key}"
    else
      "Failed to generate key"
    end
  end

  get '/get' do
    my_key = my_server.get
    if my_key
      "Key received #{my_key}"
    else
      status 404
      body "Failed to get key"
    end
  end

  get '/del' do
    my_key = params[:key]
    if my_server.del(my_key)
      "Key deleted"
    else
      status 404
      body "Failed to delete key provided"
    end  
  end

  get '/unblock' do
    my_key = params[:key]
    if my_server.unblock(my_key)
      "key unblocked"
    else
      status 404
      body "Failed to unblock key"
    end
  end

  get '/keepalive' do
    my_key = params[:key]
    if my_server.keepalive(my_key)
      "Key is alive"
    else
      status 404
      body "failed to keep alive"
    end

  end

end