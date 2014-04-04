#!/usr/bin/env ruby
%w(sinatra haml builder sass redcarpet rouge rouge/plugins/redcarpet logger).each { |v| require v }
class HTML < Redcarpet::Render::HTML 
  include Rouge::Plugins::Redcarpet 
end
set :environment, 'production'
set :markdown, layout_engine: :haml, renderer: HTML, fenced_code_blocks: true, disable_indented_code_blocks: true, tables: true, superscript: true
not_found { haml 'This is nowhere to be found.' }
set :logging, nil
err_logger = Logger.new('blog.log', 'monthly')
error do
  err_logger.error env['sinatra.error']
  'Sorry there was a error.'
end
get '/' do
  cache_control :public, :max_age => 72000
  articles = Dir['views/*.md'].map { |r| [File.basename(r, '.md'), File.mtime(r).strftime('%Y-%m-%d')] }
  haml :index, locals: { archives: articles } 
end

get '/robots.txt' do
  'Sitemap: http://cuihq.me/sitemap.xml'
end

get '/blog.css' do
  cache_control :public, :max_age => 2592000
  scss :stylesheet, :style => :expanded
end

get '/sitemap.xml' do
  content_type 'application/xml'
  articles = Dir['views/*.md'].map { |r| [File.basename(r, '.md'), File.mtime(r).strftime('%Y-%m-%d')] }
  builder :layout => false do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.urlset :xmlns =>"http://www.sitemaps.org/schemas/sitemap/0.9" do
      articles.each do |title, time|
        xml.url do
          xml.loc "http://www.cuihq.me/article/#{title}"
          xml.lastmod time
          xml.changefreq 'monthly'
        end
      end
    end
  end
end

get '/rss' do
  cache_control :public, :max_age => 72000
  content_type 'application/xml'
  articles = Dir['views/*.md'].map { |r| [File.basename(r, '.md'), File.mtime(r).rfc822()] }
  builder :layout => false do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.rss :version => "2.0" do
      xml.channel do
        xml.title "cuihq's blog"
        xml.description "cuihq's blog"
        xml.link "http://www.cuihq.me/"
        articles.each do |title, time|
          xml.item do
            xml.title title.tr('_', ' ')
            xml.link "http://www.cuihq.me/article/#{title}"
            xml.description title.tr('_', ' ')
            xml.pubDate time
          end
        end
      end
    end
  end
end

get '/article/:title' do |title|
  if File.exist?("views/#{title}.md") then markdown title.to_sym else 404 end
end

__END__

@@ index
%ul
  - for article, time in archives
    %li
      #{time}
      %a(href="/article/#{article}") #{article.tr('_', ' ')}

@@ layout
!!! 5
%html
  %head
    %title cuihq's blog
    %meta(charset='utf-8')
    %link(rel='stylesheet' href='/blog.css' type='text/css')
  %body
    %h1.header
      %a(href='/') cuihq's blog
      %a#rss(href='/rss') RSS
    %hr/
    .container= yield
    #disqus_thread
      %noscript Please enable JavaScript to view the comments. 
      :javascript
        var disqus_shortname = 'cuihqsblog';
        if (new RegExp('article').test(window.location.href)) {
          var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
          dsq.src = '//cuihqsblog.disqus.com/embed.js';
          (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        }
    %hr/
    %h2.footer
      %i powered by
      %a(href='https://github.com/cuihq/blog') cuihq

@@ stylesheet
.header a, .footer a { color: #b83000; }
#rss { background-color: #b83000; color: white; padding: 3px; text-decoration: blink; font-size: small; }
.footer { color: #888; float: right; }
pre {  color: #faf6e4; background-color: #122b3b; }
* { margin: 0; padding: 0; border: 0; font: inherit; vertical-align: baseline; }
body { font-family: Helvetica, arial, freesans, clean, sans-serif; font-size: 14px; color: #333; background-color: #fff; padding: 20px; max-width: 960px; margin: 0 auto; }
body>*:first-child { margin-top: 0 !important; }
body>*:last-child { margin-bottom: 0 !important; }
p, blockquote, ul, ol, dl, table, pre { margin: 15px 0; }
h1, h2, h3, h4, h5, h6 { margin: 20px 0 10px; padding: 0; font-weight: bold; -webkit-font-smoothing: antialiased; }
h1 tt, h1 code, h2 tt, h2 code, h3 tt, h3 code, h4 tt, h4 code, h5 tt, h5 code, h6 tt, h6 code { font-size: inherit; }
h1 { font-size: 28px; color: #000; }
h2 { font-size: 24px; border-bottom: 1px solid #ccc; color: #000; }
h3 { font-size: 18px; }
h4 { font-size: 16px; }
h5 { font-size: 14px; }
h6 { color: #777; font-size: 14px; }
body>h2:first-child, body>h1:first-child, body>h1:first-child+h2, body>h3:first-child, body>h4:first-child, body>h5:first-child, body>h6:first-child {
  margin-top: 0;
  padding-top: 0;
}
a:first-child h1, a:first-child h2, a:first-child h3, a:first-child h4, a:first-child h5, a:first-child h6 { margin-top: 0; padding-top: 0; }
h1+p, h2+p, h3+p, h4+p, h5+p, h6+p { margin-top: 10px; }
a { color: #4183C4; text-decoration: none; }
a:hover { text-decoration: underline; }
ul, ol { padding-left: 30px; }
ul li > :first-child, ol li > :first-child, ul li ul:first-of-type, ol li ol:first-of-type, ul li ol:first-of-type, ol li ul:first-of-type { margin-top: 0px; }
ul ul, ul ol, ol ol, ol ul { margin-bottom: 0; }
dl { padding: 0; }
dl dt { font-size: 14px; font-weight: bold; font-style: italic; padding: 0; margin: 15px 0 5px; }
dl dt:first-child { padding: 0; }
dl dt>:first-child { margin-top: 0px; }
dl dt>:last-child { margin-bottom: 0px; }
dl dd { margin: 0 0 15px; padding: 0 15px; }
dl dd>:first-child { margin-top: 0px; }
dl dd>:last-child { margin-bottom: 0px; }
blockquote { border-left: 4px solid #DDD; padding: 0 15px; color: #777; }
blockquote>:first-child { margin-top: 0px; }
blockquote>:last-child { margin-bottom: 0px; }
hr { clear: both; margin: 15px 0; height: 0px; overflow: hidden; border: none; background: transparent; border-bottom: 4px solid #ddd; padding: 0; }
table th { font-weight: bold; }
table th, table td { border: 1px solid #ccc; padding: 6px 13px; }
table tr { border-top: 1px solid #ccc; background-color: #fff; }
table tr:nth-child(2n) { background-color: #f8f8f8; }
img { max-width: 100%; }
pre, code, tt { font-size: 12px; font-family: Consolas, "Liberation Mono", Courier, monospace; }
code, tt { margin: 0 0px; padding: 0px 0px; white-space: nowrap; border: 1px solid #eaeaea; background-color: #f8f8f8; border-radius: 3px; }
pre>code { margin: 0; padding: 0; white-space: pre; border: none; background: transparent; }
pre { background-color: #f8f8f8; border: 1px solid #ccc; font-size: 13px; line-height: 19px; overflow: auto; padding: 6px 10px; border-radius: 3px; }
pre code, pre tt { background-color: transparent; border: none; }
kbd {
  background-color: #DDDDDD;
  background-image: linear-gradient(#F1F1F1, #DDDDDD);
  background-repeat: repeat-x;
  border-color: #DDDDDD #CCCCCC #CCCCCC #DDDDDD;
  border-image: none;
  border-radius: 2px 2px 2px 2px;
  border-style: solid;
  border-width: 1px;
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  line-height: 10px;
  padding: 1px 4px;
}
.highlight {
  color: black;
  .c, .cm, .c1 { color: #999988; font-style: italic }
  .err { color: #a61717; background-color: #e3d2d2 }
  .k, .o, .gs, .ow, .kc, .kd, .kn, .kp, .kr { font-weight: bold }
  .cp { color: #999999; font-weight: bold }
  .cs { color: #999999; font-weight: bold; font-style: italic }
  .gd { color: #000000; background-color: #ffdddd }
  .gd .x { color: #000000; background-color: #ffaaaa }
  .ge { font-style: italic }
  .gr, .gt { color: #aa0000}
  .gh, .bp { color: #999999 }
  .gi { color: #000000; background-color: #ddffdd }
  .gi .x { color: #000000; background-color: #aaffaa }
  .go { color: #888888 }
  .gp, .nn { color: #555555 }
  .gu { color: #800080; font-weight: bold }
  .kt, .nc { color: #445588; font-weight: bold }  
  .n { color: #333333 }
  .na, .nv, .no, .vc, .vg, .vi { color: teal }
  .nb { color: #0086b3 }
  .ni { color: purple}
  .ne, .nf { color: #990000; font-weight: bold }
  .nt { color: navy }
  .w { color: #bbbbbb }
  .m, .mf, .mh, .mi, .mo, .il  { color: #009999 }
  .s, .sb, .sc, .sd, .s2, .se, .sh, .si, .sx, .s1 { color: #dd1144 }
  .sr { color: #009926 }
  .ss { color: #990073 }
  .gc { color: #999; background-color: #EAF2F5 }
}
