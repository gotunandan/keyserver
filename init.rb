require 'sinatra'
require 'sinatra/reloader' if development?

$keys_time = {}
$keys_list = {}
$keys_list['available'] = []
$keys_list['blocked'] = []

require './keyserver'