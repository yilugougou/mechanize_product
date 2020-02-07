# -*- encoding : utf-8 -*-
# require 'em/pure_ruby'
class Product
  def fetch_start
    url = "https://detail.1688.com/offer/36054648174.html?spm=a2615.7691456.0.0.d3059e2TmvMaz"
    # @response = HTTParty.get(url, :headers=> {"user-agent": "Dalvik/2.1.0 (Linux; U; Android 6.0; ZTE BA520 Build/MRA58K)"})
    # url = "https://login.taobao.com/member/login.jhtml?style=b2b&css_style=b2b&from=b2b&newMini2=true&full_redirect=true&redirect_url=https%3A%2F%2Flogin.1688.com%2Fmember%2Fjump.htm%3Ftarget%3Dhttps%253A%252F%252Flogin.1688.com%252Fmember%252FmarketSigninJump.htm%253FDone%253Dhttp%25253A%25252F%25252Fdetail.1688.com%25252Foffer%25252F36054648174.html%25253Fspm%25253Da2615.7691456.0.0.d3059e2TmvMaz&reg=http%3A%2F%2Fmember.1688.com%2Fmember%2Fjoin%2Fenterprise_join.htm%3Flead%3Dhttp%253A%252F%252Fdetail.1688.com%252Foffer%252F36054648174.html%253Fspm%253Da2615.7691456.0.0.d3059e2TmvMaz%26leadUrl%3Dhttp%253A%252F%252Fdetail.1688.com%252Foffer%252F36054648174.html%253Fspm%253Da2615.7691456.0.0.d3059e2TmvMaz%26tracelog%3Dnotracelog_s_reg"
    require 'mechanize'
    Mechanize.start do |agent|
      agent.get(url, :headers=> {"user-agent": "Dalvik/2.1.0 (Linux; U; Android 6.0; ZTE BA520 Build/MRA58K)"}) do |page|
        @title = page.search('#mod-detail-title .d-title').text.strip
        @product_color = []
        page.search('.obj-leading .obj-content li').each do |color|
          @product_color.push({name: color.text.strip})
        end
        @size_infos = []
        page.search('.obj-sku .obj-content .table-sku tr').each do |size_info|
          @size_infos.push({
                               name: size_info.search('.name').text.strip,
                               price: size_info.search('.price').text.strip,
                               count: size_info.search('.count').text.strip
                           })
        end
        @product_info = ""
        page.search('#mod-detail-attributes .obj-content tr').each do |info_tr|
          info_tr.search('td').each_with_index do |td, index|
            if td.text.strip.present?
              if index%2 == 0
                @product_info += "#{td.text.strip}:"
              else
                @product_info += "#{td.text.strip}|"
              end
            end
          end
        end
      end
    end
    product_infos = []
    if @product_info.present?
      product_infos = get_products(@product_info)
    end
    {title: @title, pcolor: @product_color, psizes: @size_infos, pinfos: product_infos}
  end

  def get_products(product_info)
    product_infos = product_info.split("|")
    product_infos.map{|product| {name: product.split(":")[0], value: product.split(":")[1]}}
  end
end