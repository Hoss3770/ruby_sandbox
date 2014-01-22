class Dungeon
  attr_accessor :player

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference }
  end

  def initalize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  class Room
    def full_description
      @name + "\n\nYou are in " + @description
    end
  end
  Player = Struct.new(:name, :location)
  Room = Struct.new(:reference, :name, :description, :connections)
end
