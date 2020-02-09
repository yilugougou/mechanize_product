# -*- encoding : utf-8 -*-
# require 'em/pure_ruby'
require 'digest/md5'
class TranslationTool
  def start query
    @result = ''
    url = 'http://api.fanyi.baidu.com/api/trans/vip/translate'
    app_id = '20191215000366378'
    sec_key = 'NFOGBuq8_3gBhrKudO88'
    from = 'auto'
    to = 'fra'
    EventMachine.run {
      salt = rand(10000..99999)
      http = EventMachine::HttpRequest.new(url).post :body => {'q' => query,  'appid' => app_id, 'salt' => salt,
                                                               'from' => from, 'to' => to, 'sign' =>  buildSign(query, app_id, salt, sec_key),
                                                               'Content-Type' => 'application/x-www-form-urlencoded'}
      http.callback {
        @result = JSON.parse(http.response)
        EventMachine.stop
      }
    }
    @result
  end

  def get_tkk
    url = "https://translate.google.cn"
    response = HTTParty.get(url, :headers => {
        "User-Agent":"Mozilla/5.0 (Windows NT 6.1; rv:53.0) Gecko/20100101 Firefox/53.0"
    })
    res = response.body
    res.match('tkk:').post_match.split(',').first.split("'").last
  end

  def get_tk(q, tkk)
    require "execjs"
    context = ExecJS.compile('''
      function b(a, b) {
        for (var d = 0; d < b.length - 2; d += 3) {
          var c = b.charAt(d + 2)
          c = "a" <= c ? c.charCodeAt(0) - 87 : Number(c)
          c = "+" == b.charAt(d + 1) ? a >>> c : a << c
          a = "+" == b.charAt(d) ? a + c & 4294967295 : a ^ c
        }
        return a
      }
      function tk(TKK, a) {
        for (var e = TKK.split("."), h = Number(e[0]) || 0, g = [], d = 0, f = 0; f < a.length; f++) {
          var c = a.charCodeAt(f);
          128 > c ?
          g[d++] = c : (2048 > c ?
          g[d++] = c >> 6 | 192 : (55296 == (c & 64512) && f + 1 < a.length && 56320 == (a.charCodeAt(f + 1) & 64512) ?
          (c = 65536 + ((c & 1023) << 10) + (a.charCodeAt(++f) & 1023), g[d++] = c >> 18 | 240, g[d++] = c >> 12 & 63 | 128) : g[d++] = c >> 12 | 224, g[d++] = c >> 6 & 63 | 128), g[d++] = c & 63 | 128)
        }
        a = h;
        for (d = 0; d < g.length; d++) a += g[d],a = b(a, "+-a^+6");
        a = b(a, "+-3^+b+-f");
        a ^= Number(e[1]) || 0;
        0 > a && (a = (a & 2147483647) + 2147483648);
        a %= 1E6;
        return a.toString() + "." + (a ^ h)
      }
    ''')
    context.call('tk', tkk.to_s, q)
  end

  def start_google(qss, tl)
    result = ""
    p "qs === #{qss}"
    t = Thread.new do
      tk = get_tk(qss, get_tkk)
      q = URI::escape(qss)
      url = "https://translate.google.cn/translate_a/single?client=webapp&sl=auto&tl=#{tl}&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&source=bh&ssel=0&tsel=0&kc=1&tk=#{tk}&q=#{q}"
      # url = "https://translate.google.cn/translate_a/single"
      p "url ==== #{url}"
      response = HTTParty.post(url)
      if response[0].length > 2
        response[0].each do |res|
          if res[0].present?
            result += res[0]
          end
        end
      else
        result = response[0][0][0]
      end
      # sleep(1)
    end
    t.join
    result.split("✚")
  end

  def option_list
    str = "中文:zh-CN,阿尔巴尼亚语:sq,阿拉伯语:ar,阿姆哈拉语:am, 阿塞拜疆语:az, 爱尔兰语:ga,
    爱沙尼亚语:et ,巴斯克语:eu ,白俄罗斯语:be,
    保加利亚语:bg, 冰岛语:is, 波兰语:pl, 波斯尼亚语:bs,
    波斯语:fa, 布尔语:af, 丹麦语:da, 德语:de, 俄语:ru ,法语:fr,
    菲律宾语:tl, 芬兰语:fi, 弗里西语:fy ,高棉语:km, 格鲁吉亚语:ka,
    古吉拉特语:gu, 哈萨克语:kk, 海地克里奥尔语:ht,
    豪萨语:ha, 荷兰语:nl ,吉尔吉斯语:ky, 加利西亚语:gl, 加泰罗尼亚语:ca,
    捷克语:cs, 卡纳达语:kn, 科西嘉语:co, 克罗地亚语:hr,
    库尔德语:ku, 拉丁语:la, 拉脱维亚语:lv, 老挝语:lo, 立陶宛语:lt,
    卢森堡语:lb, 罗马尼亚语:ro, 马尔加什语:mg, 马耳他语:mt,
    马拉地语:mr, 马拉雅拉姆语:mf, 马来语:ms, 马其顿语:mk,
    毛利语:mi, 蒙古语:mn,孟加拉语:bn, 缅甸语:my, 苗语:hmn, 南非克萨语:xh, 南非祖鲁语:zu,
    尼泊尔语:ne, 挪威语:no, 旁遮普语 :pa,葡萄牙语:pt ,普什图语:ps,
    齐切瓦语:ny, 日语:ja, 瑞典语:sv, 萨摩亚语 :sm,塞尔维亚语:sr,
    赛所托语:st,僧伽罗语:si, 世界语:eo, 斯洛伐克语:sk, 斯洛文尼亚语:sl,
    斯瓦希里语:sw, 苏格兰盖尔语:gd, 宿务语:ceb, 索马里语:so, 塔吉克语:tg, 泰卢固语:te,
    泰米尔语:ta, 泰语:th, 土耳其语:tr, 威尔士语:cy, 乌尔都语:ur,
    乌克兰语:uk, 乌兹别克语:uz, 西班牙语:es, 希伯来语:rw, 希腊语:el,
    夏威夷语:haw, 信德语:sd, 匈牙利语:hu, 修纳语:sn,
    亚美尼亚语:hy, 伊博语:ig, 意大利语:it, 意第绪语:yi, 印地语:hi,
    印尼巽他:su,  印尼语:id, 印尼爪哇语:jw, 英语:en, 约鲁巴语:yo, 越南语:vi, 中文繁体:zh-TW, 中文简体:zh-CN"
    languages = str.split(',')
    languages.map{|lan| {name: lan.strip.split(':')[0], value: lan.strip.split(':')[1]}}
  end

  def start_bing(query)
    # url = "https://cn.bing.com/translator/?h_text=msn_ctxt&setlang=zh-cn"
    #url = "https://translate.google.cn/translate_a/single?client=webapp&sl=auto&tl=en&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=gt&otf=1&ssel=0&tsel=0&kc=1&tk=643372.1008181"
    # q = URI::escape(query)
    # url = "https://translate.google.cn/translate_a/single?client=webapp&sl=auto&tl=en&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=gt&pc=1&otf=1&ssel=0&tsel=0&kc=1&tk=108939.465554&q=#{q}"
    # response = HTTParty.get(url)
    # url = "https://google-translate-proxy.herokuapp.com/api/translate"
    url = "https://translate.google.cn"
    # response = HTTParty.post(url, {
    #   :body => {"query": query,"sourceLang": "auto","targetLang": "en"}.to_json
    # })

    response = HTTParty.get(url, :headers => {
        "User-Agent":"Mozilla/5.0 (Windows NT 6.1; rv:53.0) Gecko/20100101 Firefox/53.0"
    })
    res = response.body
    res.match('tkk:').post_match.split(',').first.split("'").last
    require 'mechanize'
    Mechanize.start do |agent|
      agent.get(url) do |page|
      end
    end
  end

  def buildSign(query, app_id, salt,  sec_key)
    str = "#{app_id}#{query}#{salt}#{sec_key}"
    Digest::MD5.hexdigest(str)
  end
end