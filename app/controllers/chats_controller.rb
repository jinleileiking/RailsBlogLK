class ChatsController < InheritedResources::Base
  def getChats()
    url = 'http://api.douban.com/people/jinleileiking/miniblog?start-index=1&max-results=100'

    atom = Net::HTTP.get(URI(url))
    puts Iconv.iconv("GBK//IGNORE","UTF-8//IGNORE",atom).to_s
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
    return @table
  end

  def index
    @chats = getChats 
  end
end
