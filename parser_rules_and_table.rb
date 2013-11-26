require 'scanf'

def parse_item(item)
  rules_for_item = []
  rules = item.split(" ").first.strip
  number = item.split(" ").last.scanf("(%d)").first

  tmp = ""
  rules.each_char do |char|
    if char == '\''
      tmp+= '\''
    else
      if tmp != ""
        rules_for_item << tmp
        tmp = ""
      end
      if is_upper?(char)
        tmp = char
      else
        rules_for_item << char
      end
    end
  end
  if tmp != ""
    rules_for_item << tmp
    tmp = ""
  end

  return number, rules_for_item
end

def is_upper?(str)
  !!str.match(/\p{Upper}/)
end

def parse_rules(file_path)
  f = File.open(file_path,"r")
  rules_text = f.read
  f.close

  rules = {}

  rules_text.split("\n").each do |line|
    nterm = line.split("->")[0].strip

    rules_for_nterm = {}
    items = line.split("->")[1].strip
    items.split("|").each do |item|
      number, rules_for_item = parse_item(item)
      rules_for_nterm[number] = rules_for_item
    end
    rules[nterm] = rules_for_nterm
  end

  rules
end

def parse_table(file_path)
  f = File.open(file_path,"r")
  table_text = f.read
  f.close

  table_text = table_text.gsub("hline\n","").gsub("\\bigstrut\\\\","").strip
  lines = table_text.split("\n")
  terms = lines[0].split("&")[1..-1].map{|item| item.scanf("\\textbf{%c}").first}

  table = {}

  lines[1..-1].each do |line|
    first = line.split("&").first.strip
    nterm = first.scanf("\\\\textbf{%s}").first.gsub("}","")
    table[nterm] = {}
    line.split("&")[1..-1].each_with_index do |item, index|
      num = item.strip
      if num.size > 0
        table[nterm][terms[index]] = num.to_i
      end
    end
  end
  table
end

puts parse_rules("./definitions/simple_url.rules").inspect
puts parse_table("./definitions/simple_url.table").inspect