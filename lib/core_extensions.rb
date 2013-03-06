module CoreExtensions
  
end

#Carrier Wave Patch to upload bytestream
class LyfteStringIO < StringIO
  attr_accessor :original_filename
end