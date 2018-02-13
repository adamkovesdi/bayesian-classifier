require 'classifier-reborn'

# feeds all data to a given classifier object
class Feedbrain
  def self.fill
    # return a LSI object filled with categories
    classifier = ClassifierReborn::Bayes.new
    categoryfiles.each do |cf|
      category = chopextension(cf)
      fillcategory(classifier, category, 'traindata/' + cf)
    end
    classifier
  end

  def self.fillcategory(classifier, category, filename)
    # fill the category with file
    print category + ' '
    lines = processfile(filename)
    classifier.train(category, lines)
  end

  def self.chopextension(filename)
    filename.gsub('.txt', '')
  end

  def self.processfile(filename)
    # read file to a cleaned string of text
    arr = IO.read(filename).split("\n")
    arr.map! { |line| line.split('|')[1..2].join(' ') }
    rv = arr.inject { |s, e| s + e + "\n" }
    rv.gsub!(/[^\nA-Za-z0-9 ]/, '')
  end

  def self.categoryfiles
    # scan all txt files and return as array
    Dir.entries('traindata').select { |e| e =~ /.txt/ }
  end
end
