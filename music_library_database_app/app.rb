# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'
require_relative 'lib/album'
require_relative 'lib/artist'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  not_found do
    status 404
    return "Sorry! We couldn't find this post."
  end

  post '/albums' do
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    album_repo = AlbumRepository.new
    album_repo.create(album)
    
    return nil
  end

  
 
  get '/artists' do 
    repo = ArtistRepository.new 
    @artist = repo.all
    return erb(:artists) 
  end 

  post '/artists' do
    artist_repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    artist_repo.create(artist)
    
    return nil
  end

  get '/albums/:id' do 
    artist_repo = ArtistRepository.new 
    repo = AlbumRepository.new 
    @album = repo.find(params[:id]) 
    @artist = artist_repo.find(@album.artist_id) 

   return erb(:view_album) 
  end 

  get '/artists/:id' do 
    artist_repo = ArtistRepository.new 
    @artist = artist_repo.find(params[:id]) 
    return erb(:view_artist) 
  end 

  get '/albums' do 
    album_repo = AlbumRepository.new 
    @albums = album_repo.all

   return erb(:albums) 
  end 
end 
 



