# frozen_string_literal: true

# One subway, all the lines on that subway
class Subway

  def initialize
    @lines = {}
    red_line = ['South Station', 'Park Street', 'Kendall', 'Central',
      'Harvard', 'Porter', 'Davis', 'Alewife']
      .map { |station| Station.new(station) }
    @lines['Red'] = Line.new(red_line)
    green_line = ['Haymarket', 'Government Center', 'Park Street', 'Boylston', 'Arlington',
            'Copley', 'Hynes', 'Kenmore'].map { |station| Station.new(station) }
    @lines['Green'] = Line.new(green_line)
    orange_line = ['North Station', 'Haymarket', 'Park Street', 'State',
            'Downtown Crossing', 'Chinatown', 'Back Bay', 'Forest Hills'].map { |station| Station.new(station) }
    @lines['Orange'] = Line.new(orange_line)
  end

  def count_stops(start_station, end_station, line)
    number_of_stops = @lines[line].line.find_index { |station_obj| station_obj.station_name == start_station }  - @lines[line].line.find_index { |station_obj| station_obj.station_name == end_station }
    number_of_stops.abs
  end

  def stops_between_stations(start_line, start_station, end_line, end_station)
    if start_line == end_line
      count_stops(start_station, end_station, start_line)
    end
    junction = @lines[start_line].line.find_all { |station| @lines[end_line].station_index(station.station_name) != nil }
    .sort { |station| count_stops(station.station_name, start_station, start_line) }.first
    stops_to_start_junction = count_stops(start_station, junction.station_name, start_line)
    stops_from_end_junction_to_end_station = count_stops(end_station, junction.station_name, end_line)
    stops_to_start_junction + stops_from_end_junction_to_end_station
  end
end

# One line, all the stations on that line
class Line
  attr_reader :line

  def initialize(array_station_names)
    @line = array_station_names
  end

  def station_index(station_name)
    @line.index { |station_obj| station_obj.station_name == station_name }
  end
end

# One station
class Station
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
  end
end
