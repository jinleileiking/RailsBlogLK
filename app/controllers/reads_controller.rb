class ReadsController < InheritedResources::Base
  def getBookCollection()
    require "rexml/document"
    #url = 'http://api.douban.com/people/jinleileiking/collection?cat=book&status=read&max-results=100'
    url = 'http://api.douban.com/people/jinleileiking/collection?cat=book&status=read&max-results=1000'

    atom = Net::HTTP.get(URI(url))

    @table = []
    doc=REXML::Document.new(atom)

    tmp = 0
    doc.elements.each("//entry/db:subject/title") do |e|
      @table[tmp] = {:title => e.text}
      tmp = tmp +1
    end

    tmp = 0
    doc.elements.each("//entry/db:subject/link") do |e|
      if e.attributes["rel"] == "alternate"
        @table[tmp] = @table[tmp].merge({:href => e.attributes["href"]})
        tmp = tmp +1
      end
    end
    @table
  end

  def index
    @read_from_douban = getBookCollection 
  end
end
