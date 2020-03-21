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

# Add customized color to stdoutput
RED = 31
YELLOW = 33

def colorize(color: YELLOW)
  print "\e[#{color}m"
  yield
  print "\e[0m"
end