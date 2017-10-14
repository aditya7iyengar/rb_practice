### Coordinates
#  (origin) x -->
#     y
#     |
#     V

# This solution can work for any grid size.
MAX_HEIGHT = 4

# Coordinates of a Skyscraper in the Matrix
Coordinates = Struct.new(:x, :y)

# A line of buildings could either be horizontal or vertical
# horizontal: could either be true or false
# r: is the distance of line from the origin
Line = Struct.new(:horizontal, :r)

def solve_puzzle(clues)
  matrix = Matrix.setup
  paired_clues = clue_index_pairs.map { |i1, i2| [clues[i1], clues[i2]] }
  strips = paired_clues.map.with_index &gen_strip

  while matrix.unresolved? do
    strips.each &ClueApplier.run(matrix)
  end

  matrix.humanize
end

private

# Pairs of clue indices present on opposite sides of strips
def clue_index_pairs
  (0..MAX_HEIGHT - 1).map { |x| [x, MAX_HEIGHT*3 - (x + 1)] } +
    (MAX_HEIGHT*3..(MAX_HEIGHT*4 - 1)).map { |x| [x, MAX_HEIGHT*5 - (x + 1)] }.reverse
end

# Generates a strip based on a pair of clues and their index
def gen_strip()
  ->(clues, index) {
    line = index < MAX_HEIGHT ? Line.new(false, index) : Line.new(true, index - MAX_HEIGHT)
    Strip.new(line, clues)
  }
end

# This Module is responsible to apply a set of Clues associated with a strip
# of skyscrapers to a given matrix.
module ClueApplier

  # Public API to interact with ClueApplier
  def self.run(matrix)
    ->(strip) { attempt_resolution(matrix, strip) }
  end

  # Creating a singleton class to privatize methods
  class << self
    private

    # Attemps to resolve a strip of a matrix
    def attempt_resolution(matrix, strip)
      apply_clue(matrix, strip, "clue1")
      apply_clue(matrix, strip, "clue2")
    end

    # Applies a clue to a set of matrix
    def apply_clue(matrix, strip, fn)
      skyscrapers = get_skyscrapers(matrix, strip.line)
      skyscrapers = skyscrapers.reverse if fn == "clue2"

      valid_combos =
        case strip.send(fn)
        when 0
          # Use all height combos, as this clue is of no help
          get_height_combos(skyscrapers)
        when MAX_HEIGHT
          get_height_combos(skyscrapers).select { |h| strip.send(fn) == get_visibility(h)}
        else
          get_height_combos(skyscrapers).select { |h| strip.send(fn) == get_visibility(h)}
        end

      update_skyscrapers(skyscrapers, valid_combos)
    end

    # Gets combinations of heights, based on height candidates of skyscrapers
    def get_height_combos(skyscrapers)
      (1..MAX_HEIGHT).to_a.permutation(MAX_HEIGHT).to_a.select do |combo|
        combo.map.with_index.select { |h, i| skyscrapers[i].heights.include? h }
      end
    end

    # Gets visibility of a strip of skyscrapers
    def get_visibility(strip_heights)
      visibility = 0
      hmax = 0

      strip_heights.each do |h|
        if h > hmax
          hmax = h
          visibility += 1
        end
      end

      visibility
    end

    # Updates the skyscrapers' heights using valid combinations
    def update_skyscrapers(skyscrapers, combos)
      valid_combos = combos.select do |combo|
        combo.map.with_index.all? { |h, i| skyscrapers[i].heights.include? h }
      end

      skyscrapers.each.with_index do |s, i|
        s.heights &= valid_combos.map { |combo| combo[i] }.uniq
      end
    end

    # There is only one possible arrangement if a clue == MAX_HEIGHT
    # --> [1, 2, 3 ... MAX_HEIGHT]
    def valid_combos_for_max_height
      [(1..MAX_HEIGHT).to_a]
    end

    # Get skyscrapers corresponding to a line
    def get_skyscrapers(matrix, line)
      !line.horizontal ? matrix.skyscrapers.map { |col| col[line.r] } : matrix.skyscrapers[line.r]
    end
  end
end

# This class encapsulates a matrix/grid of skyscrapers
# It keeps track of skyscrapers and their states
class Matrix
  attr_accessor :skyscrapers

  def initialize(skyscrapers)
    @skyscrapers = skyscrapers
  end

  # Creates a matrix/grid with skyscrapers having all possible heights
  def self.setup
    new((0..(MAX_HEIGHT - 1)).map do |y|
      (0..(MAX_HEIGHT - 1)).map { |x| Skyscraper.new }
    end)
  end

  # Returns true if there is any skyscraper with more than one possible
  # candidates for height
  def unresolved?
    @skyscrapers.flatten.any? { |s| s.heights.size > 1 }
  end

  # Converts the Matrix into a 2D Array
  def humanize
    @skyscrapers.map { |x| x.map { |y| y.heights[0] } }
  end
end

# This class encapsulates a Strip/Sequence of skyscrapers.
# A strip object will have two clues associated with it and it's direction
# and position is determined by the line attribute
class Strip
  attr_accessor :clue1, :clue2, :line

  def initialize(_line, clues)
    @clue1 = clues[0]
    @clue2 = clues[1]
    @line = _line
  end
end

# This class encaptulates a Skyscraper.
# It keeps track of a skyscraper's list of heights
class Skyscraper
  attr_accessor :heights

  def initialize(heights = (1..MAX_HEIGHT).to_a)
    @heights = heights
  end
end

clues = [ 2, 2, 1, 3,
          2, 2, 3, 1,
          1, 2, 2, 3,
          3, 2, 1, 3 ]

expected = [ [1, 3, 4, 2],
             [4, 2, 1, 3],
             [3, 4, 2, 1],
             [2, 1, 3, 4] ]

puts solve_puzzle(clues)
puts solve_puzzle(clues) == expected

clues    = [0, 0, 1, 2,
            0, 2, 0, 0,
            0, 3, 0, 0,
            0, 1, 0, 0]

expected = [ [2, 1, 4, 3],
             [3, 4, 1, 2],
             [4, 2, 3, 1],
             [1, 3, 2, 4] ]

puts solve_puzzle(clues) == expected
