require './definitions/simple_url'

class SimpleUrlAnalyzer < Analyzer
  include Definitions::SimpleUrl

  def initialize(options = {})
    options[:epsilon] = EPSILON
    super(INITIAL, RULES, TABLE, REPLACES, options)
  end
end