class MatchSerializer < ActiveModel::Serializer
  attributes :id, :group, :match_code, :player_1, :player_2, :score, :time, :date, :venue,

  def player_1
    object.player_1.name
  end

  def player_2
    object.player_2.name
  end

  def group
    object.group.name
  end

  def venue
    object.venue.name
  end

  def tournament
    object.tournament.name
  end
end
