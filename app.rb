%w(sinatra haml builder redcarpet rouge rouge/plugins/redcarpet).each { |v| require v }
class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end
set :markdown, layout_engine: :haml, renderer: HTML, fenced_code_blocks: true, disable_indented_code_blocks: true
ENV['RACK_ENV'] = 'production'
set :environment, 'production'
set :port, 80
not_found { haml 'This is nowhere to be found.' }
error { 'Sorry there was a error.' }

get '/' do
  articles = Dir['views/*.md'].map { |r| [File.basename(r, '.md'), File.mtime(r).strftime('%Y-%m-%d')] }
  haml :index, locals: { archives: articles } 
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
  content_type 'application/xml'
  articles = Dir['views/*.md'].map { |r| [File.basename(r, '.md'), File.mtime(r).rfc822()] }
  builder :layout => false do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.rss :version => "2.0" do
      xml.channel do
        xml.title "Bug's Blog RSS"
        xml.description "Bug Blog Posts"
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
    %title Cuihq's Blog
  %body
    %h1.header
      %a(href='/') Cuihq's Blog
      %a#rss(href='/rss') RSS
    %hr/
    .container= yield
    %hr/
    %h2.footer
      %i.footer
        powered by
        %a(href='https://github.com/cuihq/blog') Cuihq's Blog
    :css 
      .header a, .footer a { color: #b83000; }
      .container { margin: 0 auto; width: 80%; }
      #rss { background-color: #b83000; color: white; padding: 3px; text-decoration: blink; font-size: small; }
      .footer { color: #888; float: right;}
      pre { font-family: 'Ubuntu Mono', 'Monaco', monospace;}
      .highlight { color: #faf6e4; background-color: #122b3b; }
      .highlight table td { padding: 5px; }
      .highlight table pre { margin: 0; }
      .highlight .gl, .highlight .gt { color: #dee5e7; background-color: #4e5d62; }
      .highlight .c, .highlight .cd, .highlight .cm, .highlight .c1, .highlight .cs { color: #6c8b9f; font-style: italic; }
      .highlight .cp { color: #b2fd6d; font-weight: bold; font-style: italic; }
      .highlight .err, .highlight .gr { color: #fefeec; background-color: #cc0000; }
      .highlight .k, .highlight .kd, .highlight .kv { color: #f6dd62; font-weight: bold; }
      .highlight .o, .highlight .ow, .highlight .p, .highlight .pi { color: #4df4ff; }
      .highlight .gd { color: #cc0000; }
      .highlight .gi { color: #b2fd6d; }
      .highlight .ge { font-style: italic; }
      .highlight .gs { font-weight: bold; }
      .highlight .kc { color: #f696db; font-weight: bold; }
      .highlight .kn, .highlight .kp, .highlight .kr, .highlight .gh, .highlight .gu, .highlight .nl, .highlight .nt { color: #ffb000; font-weight: bold; }
      .highlight .kt, .highlight .no, .highlight .nc, .highlight .nd, .highlight .nn, .highlight .bp, .highlight .ne { color: #b2fd6d; font-weight: bold; }
      .highlight .m, .highlight .mf, .highlight .mh, .highlight .mi, .highlight .il, .highlight .mo, .highlight .mb, .highlight .mx, .highlight .ld,.highlight .ss { color: #f696db; font-weight: bold; }
      .highlight .s, .highlight .sb, .highlight .sd, .highlight .s2, .highlight .sh, .highlight .sx, .highlight .sr, .highlight .s1 { color: #fff0a6; font-weight: bold; }
      .highlight .se, .highlight .sc, .highlight .si { color: #4df4ff; font-weight: bold; }
      .highlight .nb { font-weight: bold; }
      .highlight .ni { color: #999999; font-weight: bold; }
      .highlight .w { color: #BBBBBB; }
      .highlight .nf, .highlight .py, .highlight .na { color: #a8e1fe; }
      .highlight .nv, .highlight .vc, .highlight .vg, .highlight .vi { color: #a8e1fe; font-weight: bold; }

