# frozen_string_literal: true

class Movie
  attr_reader :title,
              :id,
              :overview,
              :genre,
              :runtime,
              :vote_average,
              :poster_path,
              :cast,
              :review, 
              :image 

  def initialize(response)
    @title = response[:title]
    @id = response[:id]
    @overview = response[:overview]
    @genre = response[:genres]
    @runtime = format_runtime(response[:runtime])
    @vote_average = response[:vote_average]
    @poster_path = response[poster_path:]
    @image = response[:image]
  end

  def format_runtime(time)
    if time
      hours = time / 60
      minutes = time % 60
      "#{hours}h #{minutes}min"
    else
      'No run time'
    end
  end
end
