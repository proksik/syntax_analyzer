require './definitions/simple_test'

class SimpleTestAnalyzer < Analyzer
  include Definitions::SimpleTest

  def initialize(options = {})
    super(INITIAL, RULES, TABLE, REPLACES, options)
  end
end