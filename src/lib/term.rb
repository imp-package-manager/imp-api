require_relative "pipe"

module Term

  extend self

  COL_DEFAULT = "\e[39m"
  COL_RED     = "\e[31m"
  COL_GREEN   = "\e[32m"

  def width
    pipe = Pipe.go! "tput cols"
    pipe.out.to_i
  end

  def hr
    STDERR.puts "─" * width
  end

  def clear
    pipe = Pipe.go! "clear"
    STDERR.puts pipe.out
  end

end
