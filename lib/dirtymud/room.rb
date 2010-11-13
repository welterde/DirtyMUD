module Dirtymud
  class Room
    attr_accessor :id, :description, :players, :exits, :server

    def initialize(attrs)
      @players = []
      @exits = {}

      attrs.each do |k, v| 
        self.send("#{k}=", v)
      end
    end

    def enter(player)
      player.room = self
      players.push(player)
      # annoucne to other players that they've entered the room
      announce("#{player.name} has entered the room.", :except => player)
    end

    def leave(player)
      players.delete(player)
      # annoucne to other players that they've left the room
      announce("#{player.name} has left the room.", :except => player)
    end

    def announce(message, options = {})
      # puts "Announcing in room #{id}: `#{message}`"
      server.announce(message, options.merge(:only => players))
    end
  end
end
