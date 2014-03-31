%w(sinatra haml builder sass redcarpet rouge rouge/plugins/redcarpet).each { |v| require v }
Redcarpet::Render::HTML.send :include, ::Rouge::Plugins::Redcarpet
set :markdown, layout_engine: :haml, fenced_code_blocks: true, disable_indented_code_blocks: true
set :views, '.'
set :environment, 'production'
set :port, 80
not_found { haml 'This is nowhere to be found.' }
error { 'Sorry there was a error.' }

get '/' do
  cache_control :public, :max_age => 72000
  articles = Dir['*.md'].map { |r| [File.basename(r, '.md'), File.mtime(r).strftime('%Y-%m-%d')] }
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
  articles = Dir['*.md'].map { |r| [File.basename(r, '.md'), File.mtime(r).strftime('%Y-%m-%d')] }
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
  content_type 'application/xml'
  articles = Dir['*.md'].map { |r| [File.basename(r, '.md'), File.mtime(r).rfc822()] }
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
  if File.exist?("#{title}.md") then markdown title.to_sym else 404 end
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
      %a(href='https://github.com/cuihq/blog') cuihq's blog

@@ stylesheet
.header a, .footer a { color: #b83000; }
.container, #disqus_thread { margin: 0 auto; width: 80%; }
#rss { background-color: #b83000; color: white; padding: 3px; text-decoration: blink; font-size: small; }
.footer { color: #888; float: right; }
pre { 
  font-family: 'Ubuntu Mono', 'Monaco', monospace;
  color: #faf6e4; background-color: #122b3b;
  table td { padding: 5px; }
  table pre { margin: 0; }
  .gl, .gt { color: #dee5e7; background-color: #4e5d62; }
  .c, .cd, .cm, .c1, .cs { color: #6c8b9f; font-style: italic; }
  .cp { color: #b2fd6d; font-weight: bold; font-style: italic; }
  .err, .gr { color: #fefeec; background-color: #cc0000; }
  .k, .kd, .kv { color: #f6dd62; font-weight: bold; }
  .o, .ow, .p, .pi { color: #4df4ff; }
  .gd { color: #cc0000; }
  .gi { color: #b2fd6d; }
  .ge { font-style: italic; }
  .gs { font-weight: bold; }
  .kc { color: #f696db; font-weight: bold; }
  .kn, .kp, .kr, .gh, .gu, .nl, .nt { color: #ffb000; font-weight: bold; }
  .kt, .no, .nc, .nd, .nn, .bp, .ne { color: #b2fd6d; font-weight: bold; }
  .m, .mf,  .mh, .mi, .il, .mo, .mb, .mx, .ld, .ss { color: #f696db; font-weight: bold; }
  .s, .sb, .sd, .s2, .sh, .sx, .sr, .s1 { color: #fff0a6; font-weight: bold; }
  .se, .sc, .si { color: #4df4ff; font-weight: bold; }
  .nb { font-weight: bold; }
  .ni { color: #999999; font-weight: bold; }
  .w { color: #BBBBBB; }
  .nf, .py, .na { color: #a8e1fe; }
  .nv, .vc, .vg, .vi { color: #a8e1fe; font-weight: bold; }
}
