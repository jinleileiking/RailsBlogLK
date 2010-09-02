class ArticlesController < InheritedResources::Base
  def getArticlesCollection()
    require "rexml/document"
    #url = 'http://api.douban.com/people/jinleileiking/collection?cat=book&status=read&max-results=100'
    url = 'http://api.douban.com/people/jinleileiking/notes'
    #url = 'http://api.douban.com/people/jinleileiking/notes?start-index=1&max-results=1'

    atom = Net::HTTP.get(URI(url))

    @table = []
    doc=REXML::Document.new(atom)

    tmp = 0
    doc.elements.each("//entry/title") do |e|
      @table[tmp] = {:title => e.text}
      tmp = tmp +1
    end


    tmp = 0
    doc.elements.each("//entry/content") do |e|
      @table[tmp] = @table[tmp].merge({:content => e.text})
      tmp = tmp +1
    end

    tmp = 0
    doc.elements.each("//entry/published") do |e|
      e.text[/(.+)T(.+)\+/]
      text = "#{$1} #{$2}"
      @table[tmp] = @table[tmp].merge({:published => text})
      tmp = tmp +1
    end
    
    tmp = 0
    doc.elements.each("//entry/link") do |e|
      if e.attributes["rel"] == "alternate"
        @table[tmp] = @table[tmp].merge({:href => e.attributes["href"]})
        tmp = tmp +1
      end
    end

    @table
  end

  def index
    @articles = getArticlesCollection
  end
end
