Syntax Analyzer
===============

Parsing rules and table from tex
----------------

parser_rules_and_table


SimpleTest analyzer
----------------

test_analyzer = SimpleTestAnalyzer.new(mode: 'details')
test_analyzer.analyze_file(File.expand_path('examples/simple_test.in', File.dirname(__FILE__)))
test_analyzer.analyze_text('a+(a)*q')


SimpleUrl analyzer
----------------

simple_url_analyzer = SimpleUrlAnalyzer.new(mode: 'normal') # mode: normal, details, debug
simple_url_analyzer.analyze_file(File.expand_path('examples/simple_url.in', File.dirname(__FILE__)))
simple_url_analyzer.analyze_text('http://naseobce.sk')


