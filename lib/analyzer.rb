class Analyzer

  attr_accessor :initial, :rules, :table, :replaces, :options

  def initialize(initial = nil, rules = {}, table = {}, replaces = [], options)
    @options = {end_terminal: '$', epsilon: 'eps', mode: 'analyse'}.merge!(options)
    @initial= initial
    @table = table
    @rules = rules
    @replaces= replaces
  end

  def prepare(text)
    processed_text = text.clone
    replaces.each do |replace_items|
      if replace_items[0].is_a?(String)
        text.gsub!(replace_items[0], replace_items[1])
        processed_text.gsub!(replace_items[0], '#')
      end
    end

    tokens = text.split(//)
    processed_tokens = processed_text.split(//)

    tokens.each_with_index.each do |token, index|
      if processed_tokens[index] != '#'
        replaces.each do |replace_items|
          if replace_items[0] == :letters
            tokens[index] = replace_items[1] if letter?(token)
          elsif replace_items[0] == :digits
            tokens[index] = replace_items[1] if numeric?(token)
          end
        end
      end
    end
    tokens << options[:end_terminal]
  end

  def analyze_text(text)
    puts "Analyze text: #{text}"
    analyze prepare(text)
  end

  def analyze_file(filepath)
    file = File.open(filepath)
    texts = file.read
    file.close
    texts.split("\n").each do |text|
      analyze_text text
    end
  end

  def analyze(tokens)
    stack = []

    if details_mode?
      puts "Tokens: #{tokens}"
    end

    stack.push options[:end_terminal]
    stack.push initial

    while tokens.size > 0
      if debug_mode?
        puts "TopStack: #{stack.reverse.first}, FirstTerm: #{tokens.first}, Stack: #{stack.reverse.inspect}, Tokens: #{tokens.inspect}"
      end
      top_item = stack.pop
      first_term = tokens.first
      if terminal?(top_item)
        # if terminal and not same with first in word
        if first_term == top_item
          if debug_mode?
            puts "Pop #{tokens.first} from input"
          end
          # remove first
          tokens.shift
        else
          # problem with analyze
          debug_output(top_item, first_term, stack, tokens)
          puts "ANALYSE: FALSE  \n\n"
          return false
        end
      else
        # normal evaluation
        rule_number = table[top_item][first_term]
        add_rules = rules[top_item][rule_number]
        if add_rules.nil? || add_rules.empty?
          debug_output(top_item, first_term, stack, tokens) if details_mode?
          puts "ANALYSE: FALSE  \n\n"
          return false
        end
        add_rules.reverse.each do |item|
          stack.push item unless epsilon?(item)
        end

        # debug mode
        if details_mode?
          puts "Use rule: #{rule_number}"
        end
      end
    end

    puts "ANALYZE: TRUE\n\n"
    true
  end

  private

  def debug_output(top_item, first_term, stack, tokens)
    puts "Problem in top_stack: #{top_item}, first_input: #{first_term}, stack: #{stack.reverse}, input: #{tokens}"
  end

  def terminal?(term)
    term.size == 1 && !is_upper?(term)
  end

  def is_upper?(str)
    !!str.match(/\p{Upper}/)
  end

  def epsilon?(item)
    item == options[:epsilon]
  end

  def details_mode?
    options[:mode] == 'details' || debug_mode?
  end

  def debug_mode?
    options[:mode] == 'debug'
  end

  def letter?(char)
    char =~ /[[:alpha:]]/
  end

  def numeric?(char)
    char =~ /[[:digit:]]/
  end

end