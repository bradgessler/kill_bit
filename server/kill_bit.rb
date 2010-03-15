require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'dm-core'
require 'dm-timestamps'

DataMapper.setup(:default, 'sqlite3:kill_bit.db')

class Request
  include DataMapper::Resource
  
  property :id,           Serial,   :key => true
  property :ip,           String
  property :kill_bit_id,  Integer
  property :created_at,   DateTime
  
  belongs_to :kill_bit
end

class KillBit
  include DataMapper::Resource
  
  property :id,           Serial,   :key => true
  property :name,         String
  property :killed,       Boolean,  :default => false
  property :killed_at,    DateTime
  property :created_at,   DateTime
  property :updated_at,   DateTime
  
  has n, :requests
  
  def request(env)
    requests << Request.new(:ip => env['REMOTE_ADDR'])
    save
  end
end

DataMapper.auto_upgrade!

get '/' do
  @kill_bits = KillBit.all
  haml :kill_bits
end

get '/favicon.ico' do
end

get '/new' do
  @kill_bit = KillBit.new
  haml :edit
end

get '/:id/edit' do
  @kill_bit = KillBit.get(params[:id])
  haml :edit
end

get '/:id/killed' do
  @kill_bit = KillBit.get(params[:id])
  @kill_bit.request(env)
  @kill_bit.killed ? '1' : '0'
end

get '/:id/requests' do
  if @kill_bit = KillBit.get(params[:id])
    @requests = @kill_bit.requests
    haml :requests
  else
    halt [404, "Not Found"]
  end
end

post '/' do
  @kill_bit = KillBit.new(params[:kill_bit])
  if @kill_bit.save
    redirect "/#{@kill_bit.id}"
  else
    halt 406, "Something did't save"
  end
end

put '/:id' do
  @kill_bit = KillBit.get(params[:id])
end

get '/:id' do
  @kill_bit = KillBit.get(params[:id])
  haml :kill_bit
end