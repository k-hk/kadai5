# coding: utf-8
require 'dxruby'

require_relative 'player'
require_relative 'enemy'

Window.width  = 800
Window.height = 600
gf = 0

player_img = Image.load("player.png")
player_img.setColorKey([0, 0, 0])

enemy_img = Image.load("enemy.png")
enemy_img.setColorKey([0, 0, 0])
clear_img = Image.load("clear.png")
over_img = Image.load("over.png")
t = 0
player = Player.new(400, 300, player_img)
enemies = []
v = 1
n = 1
font = Font.new(20)
font2 = Font.new(36)
score = 0

Window.loop do
  break if Input.keyPush?(K_ESCAPE)
  if gf == 1
    if score >= 3600
      Window.draw( 0, 0, clear_img, z=0 )
      Window.draw_font(40, 450,"GAME CLEAR", font2)
      Window.draw_font(20, 500,"君のおかげで悪を倒すことができた!ありがとう!", font2)
      Window.draw_font(460, 550,"score: #{score}", font2)
    else
      Window.draw( 0, 0, over_img, z=0 )
      Window.draw_font(40, 450,"GAME OVER", font2)
      Window.draw_font(200, 500,"俺の人生もここまでか・・・　score: #{score}", font2)
    end
    next
  end
  if t <= 3600
    Window.draw_font(0, 0,"悪を倒すパワーがたまるまで逃げ続けてくれ!!　残り#{60 - t/60}秒", font)
  else
    Window.draw_font(0, 0,"悪は倒せるが、さらなる強敵のためにパワーをもっとためてくれ!!　＋#{t/60 - 60}秒", font)
  end
  t += 1
  if t % 60 ==0
    num = 0 
    while num != n do 
      if rand(4) == 0
        enemy = Enemy.new(rand(800), 0, enemy_img)
        enemy.speed(player.x,player.y,v) 	
      elsif rand(4) == 1
  	    enemy = Enemy.new(rand(800), 600, enemy_img)
        enemy.speed(player.x,player.y,v)
      elsif rand(4) == 2
        enemy = Enemy.new(0 , rand(600), enemy_img)
        enemy.speed(player.x,player.y,v)
      else
        enemy = Enemy.new(800, rand(600), enemy_img)
        enemy.speed(player.x,player.y,v)
      end
      enemies << enemy
      num += 1
    end
  end
  if t % 720 == 0
  	n += 1
  	if v != 6
      v += 1
    end
  end
  Sprite.update(enemies)
  Sprite.draw(enemies)

  player.update
  player.draw

  # 当たり判定
  if Sprite.check(player, enemies)
  	score = t
  	gf = 1
  end
  
end