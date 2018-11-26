module Nmax
  # class for searching biggest n numbers in text
  class Finder
    attr_reader :lines, :numbers_count

    def initialize(lines, numbers_count)
      @lines = lines
      @numbers_count = numbers_count
    end

    def call
      all_numbers.sort.reverse.take(numbers_count)
    end

    private

    def all_numbers
      [].tap do |numbers|
        lines.each { |line| numbers.concat(find_numbers(line)) }
      end
    end

    def find_numbers(line)
      regexp = /\b(?<!\.)[1-9]\d{,999}(?!\.)\b/
      line.scan(regexp).map(&:to_i)
    end
  end
end
