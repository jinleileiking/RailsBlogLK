#coding:utf-8
module ApplicationHelper
  def get_menu_haml(menus)
    menus = ["日记", "相册", "闲聊", "自我介绍"]
    i = 1
    haml = ''
    menus.each do |menu|
      haml += ".grid#{i*2}\r\n"
      haml += "  =link_to #{menu}, #{menu}_path\r\n"
      i += 1
    end
    haml
  end
end
