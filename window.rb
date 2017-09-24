require 'gosu'

WIDTH = 512
HEIGHT = 512

class GameWindow < Gosu::Window
  
  def initialize
    super WIDTH, HEIGHT
    self.caption = "Desert Falcon"
    @background_image = Gosu::Image.new(self, "images.jpg", true)
  end

  def update
  end

  def draw
    @background_image.draw(150, 100, 50);
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show