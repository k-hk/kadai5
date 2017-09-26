# coding: utf-8

class Player < Sprite
	#attr_accessor :x, :y
  def update
    self.x += ( Input.x * 6 )
    self.y += ( Input.y * 6 )
  end
end