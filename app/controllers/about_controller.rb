class AboutController < InheritedResources::Base
  def getMyInfo()
    url = 'http://api.douban.com/people/jinleileiking'

    atom = Net::HTTP.get(URI(url))
    puts Iconv.iconv("GBK//IGNORE","UTF-8//IGNORE",atom).to_s
    @table = []
    doc=REXML::Document.new(atom)

    tmp = 0
    doc.elements.each("//entry/title") do |e|
      @table[tmp] = {:name => e.text}
      tmp = tmp +1
    end

    tmp = 0
    doc.elements.each("//entry/content") do |e|
      doc = Maruku.new(e.text)
      puts doc.to_html
      @table[tmp] = @table[tmp].merge({:intro => doc.to_html})
      tmp = tmp +1
    end
    return @table
  end

  def index
    @owner_info = getMyInfo.first
  end
end
