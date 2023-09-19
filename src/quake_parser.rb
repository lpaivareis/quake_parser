# frozen_string_literal: true

require 'byebug'
require 'awesome_print'

class QuakeParser
  def initialize
    @all_matches = []
  end

  def log_games
    parse

    awesome_print(matches_data)
  end

  private

  attr_reader :all_matches

  def parse
    match_log = []

    File.foreach('files/qgames.log') do |line|
      clear_match_log(match_log) if validate_init_game(line, match_log)

      add_match_log(match_log, line)

      add_all_matches(match_log) if line.include?('ShutdownGame:')
    end
  end

  def validate_init_game(line, match_log)
    line.include?('InitGame:') && !match_log.empty?
  end

  def add_match_log(match_log, line)
    match_log << line
  end

  def add_all_matches(match_log)
    all_matches << match_log.dup
  end

  def clear_match_log(match_log)
    match_log.clear
  end

  def matches_data
    parsed_matches = {}

    all_matches.each_with_index do |game, index|
      match = {
        total_kills: total_kills(game)
      }

      parsed_matches["game_#{index + 1}"] = match.merge(match_statistics(game))
    end

    parsed_matches
  end

  def total_kills(match)
    match.count { |line| line.include?('Kill:') }
  end

  def match_statistics(match)
    players = []
    kills = {}
    kills_by_means = {}

    match.each do |line|
      players << get_players(line) if line.include?('ClientUserinfoChanged:')

      kills, kills_by_means = match_data(line, kills, kills_by_means) if line.include?('Kill:')
    end

    { players: players.uniq, kills:, kills_by_means: }
  end

  def match_data(line, kills, kills_by_means)
    kills = get_kills(line, kills)
    kills_by_means = get_kills_by_means(line, kills_by_means)

    [kills, kills_by_means]
  end

  def get_players(line)
    line.match(/n\\(.*?)\\t/)[1]
  end

  def get_kills(line, kills)
    match_data = line.match(/Kill:\s+\d+\s+\d+\s+\d+:\s+(.+?)\skilled\s+(.+?)\s+by/)
    return unless match_data

    killer = match_data[1].strip
    killed = match_data[2].strip

    update_kills(kills, killer, killed)

    kills.delete('<world>')

    kills
  end

  def update_kills(kills, killer, killed)
    if killer == '<world>'
      kills[killed] = kills[killed].to_i - 1
    else
      kills[killer] = kills[killer].to_i + 1
    end
  end

  def get_kills_by_means(line, kills_by_means)
    mean = line.split('by', 2).last.strip

    kills_by_means[mean] = kills_by_means[mean].to_i + 1

    kills_by_means
  end
end

QuakeParser.new.log_games
