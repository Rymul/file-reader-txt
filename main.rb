# Returns the path of all text files in a given direcotry
def get_all_txt_files(path_to_dir)
    files = Dir[path_to_dir + '/*.txt']
end

# Returns a hash with a count of all words
def parse_txt_file(path_to_file)
    words = []
    file = File.open(path_to_file)
    file_data = file.readlines.map(&:chomp)
    file_data.each { |sentence| words.concat(sentence.split(/[^[[:word:]]']+/)) }
    file.close

    Hash.new(0).tap { |h| words.each { |word| h[word.downcase] += 1 } }
end

# Accepts text as an input and returns it as green text
def green_txt(mytext)
    "\e[32m#{mytext}\e[0m"
end

# Given a file path, and a word counter hash, print the data in an organized manner
def print_analytics(path, hash)
    puts 'FILE: ' + green_txt(path)
    puts hash
    
end

def main()
    # retrieve all local .txt files inside of '<CUR_DIR>/text-files'
    path = Dir.pwd + '/text-files'
    files = get_all_txt_files(path)

    # Parse each text file and save the data in a hash called `file_hash` as:
    # key -> path to text file
    # value -> hash of the word counter
    file_hash = Hash.new()
    files.each { |file| file_hash[file.split('/')[-1]] = parse_txt_file(file) }
    p file_hash
    # Print the analytics per file
    file_hash.each { |k, v| print_analytics(k, v) }
end

main()
