require 'bundler'

# Copy from: https://www.rubydoc.info/gems/seqtrimnext/String:decamelize
def decamelize(string)
  string.to_s.
    gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2').
    gsub(/([a-z]+)([A-Z\d])/, '\1_\2').
    gsub(/([A-Z]{2,})(\d+)/i, '\1_\2').
    gsub(/(\d+)([a-z])/i, '\1_\2').
    gsub(/(.+?)\&(.+?)/, '\1_&_\2').
    gsub(/\s/, '_').downcase
end

# Copy from: https://apidock.com/rails/v5.2.3/ActiveSupport/Inflector/demodulize
def demodulize(path)
  path = path.to_s
  if i = path.rindex("::")
    path[(i + 2)..-1]
  else
    path
  end
end

class GemNode
  attr_reader :name, :version, :file_path
  def initialize(name: nil, version: nil, file_path: nil)
    @name = name
    @version = version
    @file_path = file_path
  end

  def show
    print "\e[33m"
    puts "<< #{@name} >>"
    puts "version: #{@version}"
    puts "path : #{@file_path}"
    print "\e[0m"
  end
end

class GemViewer
  def initialize
    @gem_map = {}
    @target_gem_path = nil
    @target_file_path = nil

    create_map()
  end

  def create_map
    Bundler.load.specs.each do |gem|
      @gem_map["#{gem.name.to_s}"] = GemNode.new(name: gem.name.to_s, version: gem.version.to_s, file_path: gem.full_gem_path)
    end
  end

  def open_gem(gem_name)
    format_gem_name = gem_name.to_s[0, gem_name.index("::") || gem_name.length]
    target_gem = @gem_map[decamelize(format_gem_name)] || @gem_map[format_gem_name.downcase()]
    @target_gem_path = target_gem.file_path

    target_gem.show()
    system("code --add #{@target_gem_path }")
  end

  def open_file(gem_name)
    target_file = demodulize(gem_name)
    target_file = decamelize(target_file) + '.rb'

    recursive_find(@target_gem_path, target_file)

    print "\e[33m"
    puts "<< #{target_file} >>"
    puts 'path: ' + @target_file_path
    print "\e[0m"

    system("code #{@target_file_path}")
  end

  def recursive_find(dir_path, target_file)
    Dir[dir_path + '/**'].each do |file_path|
      if file_path == dir_path + '/' + target_file
        @target_file_path = file_path
      elsif File.directory? file_path
        recursive_find(file_path, target_file)
      end
    end
  end
end

for arg in ARGV
  gv = GemViewer.new()
  gv.open_gem(arg)
  gv.open_file(arg)
end