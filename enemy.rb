# coding: utf-8

class Enemy < Sprite

  def speed(x,y,v)
    at = Math.atan2((y - self.y),(x - self.x))
    @v_x = Math.cos(at) * v
    @v_y = Math.sin(at) * v
  end

  def update
    self.y = self.y + @v_y
    self.x = self.x + @v_x
    if self.y >= Window.height - self.image.height
      self.vanish
    end
  end

  # 他のオブジェクトから衝突された際に呼ばれるメソッド
=begin  def hit(obj)
    self.vanish
  end
=end
end