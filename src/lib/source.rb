class Source

  @source
  @target
  @type

  @fileI
  @fileO

  def initialize(source, target)

     source = source.split("::")
    @source = source[-1]
    @target = File.expand_path(@source.split("/")[-1], target)

    if @source =~ /\Ahttp(s)?:\/\//
      @type = :net
    else
      @type = :aur
    end

  end

  def to_s
    @source
  end

  def retrieve
 
    File.open(@target, 'w') do |file|

      begin

        case @type
        when :net;
          fileI = retrieveNet
        when :aur;
          fileI = retrieveAur
        end

      rescue
        Err << "unreadable input file"
      end

    end rescue
    begin
      Err << "unreadable output file"
    end

  end

  def extract

    extensions = []
    tmp = @target

    begin

      extension = File.extname(tmp)
      tmp = File.basename(tmp, ".*")

      valid = (!extension.empty? and extension =~ /[a-zA-Z]/)

      if valid
        extensions.push extension[1..-1]
      end

    end while valid

    current = Dir.pwd
    archive = File.basename(@target)
    Dir.chdir File.dirname(@target)

    if extensions.include? "tar"

      Console.log("extracting", @target)
      command = String.new

      command << "tar -"
      command << "z" if extensions.any? { |it| it =~ /.z/ and it != "xz" }
      command << "xf "
      command << archive

      Pipe.go! command

    elsif extensions.include? "deb"

      Console.log("extracting", @target)
      command = String.new

      command << "ar -x "
      command << @target

      Pipe.go! command

    end

    Dir.chdir current

  end

  private

  def retrieveNet

    url = URI(@source)

    Net::HTTP.start(url.hostname) do |http|
      head = http.request_head(url)
    end

    uri = URI.parse @source
    uri.open.read

  end

  def retrieveAur
    File.open(@source).read
  end

end
