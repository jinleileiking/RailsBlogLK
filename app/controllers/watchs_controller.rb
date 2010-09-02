class WatchsController < InheritedResources::Base
  def getMovieCollection()
    #url = 'http://api.douban.com/people/jinleileiking/collection?cat=movie&status=watched&max-results=100'
    url = 'http://api.douban.com/people/jinleileiking/collection?cat=movie&status=watched&max-results=1000'
    #    Net::HTTP.version_1_2
    #    open(url)do|http|
    #      atom = http.read

    atom = Net::HTTP.get(URI(url))
    puts Iconv.iconv("GBK//IGNORE","UTF-8//IGNORE",atom).to_s
    @table = []
    doc=REXML::Document.new(atom)

    #             <db:attribute lang="zh_CN" name="aka">姐姐的守护者</db:attribute>
    #    doc.elements.each("//entry/db:subject/db:attribute") do |e|
    #      if e.attributes["lang"] == "zh_CN"
    #        @table[tmp] = {:title => e.text}
    #        tmp = tmp +1
    #      end
    #    end
    tmp = 0
    doc.elements.each("//entry/db:subject/title") do |e|
      #      gbk = to_gbk(e.text)
      #      p gbk
      #      Iconv.iconv("UTF-8//IGNORE","GB2312//IGNORE",e.text)
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
    return @table
  end

  def index
    @watched_from_douban = getMovieCollection
  end
end
