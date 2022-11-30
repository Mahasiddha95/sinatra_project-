# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

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

  get '/albums/:id' do
    id = params[:id].to_i
    album_repo = AlbumRepository.new
    album = album_repo.find(id)
    return "id=#{album.id},title=#{album.title},release_year=#{album.release_year},artist_id=#{album.artist_id}"
  end
 
  get '/artists' do 
    repo = ArtistRepository.new 
    artists = repo.all 
    
    result = artists.map do |artist|
      artist.name 
    end 
   return result.join(', ')
  end 

  post '/artists' do
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    artist_repo = ArtistRepository.new
    artist_repo.create(artist)
    
    return ""
  end

  get '/albums_id/:id' do 
    artist_repo = ArtistRepository.new 
    repo = AlbumRepository.new 
    @album = repo.(params[:id]) 
    @artist = artist_repo.find(@album.artist_id) 

   return erb(:album) 
  end 
end 
 



