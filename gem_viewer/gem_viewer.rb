require_relative './helper'

class GemNode
  attr_reader :name, :version, :file_path
  def initialize(name: nil, version: nil, file_path: nil)
    @name = name
    @version = version
    @file_path = file_path
  end

  def to_s
    "<< #{@name} >>\nversion: #{@version}\npath : #{@file_path}"
  end
end

class GemViewer
  def initialize(gem_name: nil)
    @target_gem = load_gem(gem_name)
  end

  def load_gem(gem_name)
    # create map
    gem_map = {}
    Bundler.load.specs.each do |gem|
      gem_map["#{gem.name.to_s}"] = GemNode.new(name: gem.name.to_s, version: gem.version.to_s, file_path: gem.full_gem_path)
    end

    target_gem = gem_map[decamelize(gem_name)] || gem_map[gem_name.downcase()]
    colorize { puts target_gem }

    target_gem
  end

  def open_file(target_file)
    target_file_paths = find(@target_gem.file_path, target_file)

    unless target_file_paths.empty?
      colorize do
        puts "==== found multiple files ====" if target_file_paths.length > 1
        puts "<< #{target_file} >>"
        target_file_paths.each do |path|
          puts 'path: ' + path
        end
        puts "==== open the first one ====" if target_file_paths.length > 1
      end

      system("code #{target_file_paths[0]}")
    else
      colorize(color: RED) { puts "<< #{target_file} is not found>>" }
    end
  end

  def find(dir_path, target_file)
    result = []
    queue = [dir_path]

    while queue.length > 0
      current_path = queue.shift
      Dir[current_path + '/**'].each do |file_path|
        if File.directory? file_path
          queue.push(file_path)
        elsif file_path == current_path + '/' + target_file
          result.push(file_path)
        end
      end
    end

    result
  end
end
