class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']
# filename is entered in the test...
  def initialize(filename)
    @words = File.read(filename).downcase.gsub(/[^a-z0-9\s]/i, '').split.delete_if{|word| STOP_WORDS.include?(word)}


    @frequencies = frequencies
    @top_words = top_words(10)
  end

  def frequency(word)
    @frequencies[word]
  end

  def frequencies
    # .tap literally taps each word and records how many taps
    Hash.new(0).tap { |h| @words.each { |word| h[word] += 1 } }

  end

  def top_words(number)
    # .to_h makes to a hash
    results = @frequencies.sort_by{|key,val| val}.reverse.take(number).to_h
    # take means takes the number of results
    p results
  end

  def print_report
  #  frequency("power")
  top10 = top_words(10)
  result = top10.each do |key, value|
    asstrick = "*" * value
    # print " #{value}, #{key}, #{asstrick}"
    printf("%7s | %1d %1s \n", key, value, asstrick)
  end
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
