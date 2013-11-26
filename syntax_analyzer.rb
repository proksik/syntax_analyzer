Dir['./lib/*.rb'].each { |f| require f }

# Test analyzer

#test_analyzer = SimpleTestAnalyzer.new(mode: 'details')
#test_analyzer.analyze_file(File.expand_path('examples/simple_test.in', File.dirname(__FILE__)))
#test_analyzer.analyze_text('a+(a)*q')
#test_analyzer.analyze_text('a+(a)*++')
#test_analyzer.analyze_text('a+(a)*')
#test_analyzer.analyze_text('')
#test_analyzer.analyze_text('a+(b+b)*a')

# --------------------------------------------------------------------------------------

# SimpleUrl analyzer
#mode: normal, details, debug

simple_url_analyzer = SimpleUrlAnalyzer.new(mode: 'normal')
simple_url_analyzer.analyze_file(File.expand_path('examples/simple_url.in', File.dirname(__FILE__)))
#simple_url_analyzer.analyze_text('mailto::aaaa.b')
#simple_url_analyzer.analyze_text('http://na.sk/sa/sa?sa+sa')
#simple_url_analyzer.analyze_text('http://aaa.bbb.cc:55/a/b/c?x+y+z')
#simple_url_analyzer.analyze_text('mailto::aaa@a.b')
#simple_url_analyzer.analyze_text('telnet://a.b:8')
#simple_url_analyzer.analyze_text('telnet://a@a.b:8')
#simple_url_analyzer.analyze_text('telnet://a:b@a.b:8')

