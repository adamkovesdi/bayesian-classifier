require 'classifier-reborn'
require 'pry'

# feeds all data to a given LSI object
class Feedbrain
  def self.fill
    # return a LSI object filled with categories
    lsi = ClassifierReborn::LSI.new
    categoryfiles.each do |cf|
      category = chopextension(cf)
      fillcategory(lsi, category, 'traindata/' + cf)
    end
    lsi
  end

  def self.fillcategory(classifier, category, filename)
    # fill the category with file
    puts "Processing #{category}"
    lines = processfile(filename)
    classifier.add_item(lines, category)
  end

  def self.processfile(filename)
    # read file to a cleaned string of text
    arr = IO.read(filename).split("\n")
    arr.map! { |line| line.split('|')[1..2].join(' ') }
    rv = arr.inject { |s, e| s + e + "\n" }
    rv.gsub!(/[^\nA-Za-z0-9 ]/, '')
  end

  def self.chopextension(filename)
    filename.gsub('.txt', '')
  end

  def self.categoryfiles
    # scan all txt files and return as array
    Dir.entries('traindata').select { |e| e =~ /.txt/ }
  end
end

# lsi = Feedbrain.fill
# File.open('classifier.dat', 'w') { |f| f.write(Marshal.dump(lsi)) }
# lsi = Marshal.load(File.read('classifier.dat'))

# binding.pry
