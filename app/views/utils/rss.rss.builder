xml.instruct! :xml, :version => "1.0"

xml.rss "version" => "2.0" do
 xml.channel do
   xml.title       @conf.title
   xml.description @conf.resume
   xml.link         root_path	

   for article in @articles
     xml.item do
       xml.title       article.title
       xml.description sanitize(RDiscount.new(article.description).to_html)

       xml.link        article.url_article
       xml.guid        article.url_article
     end
   end
 end
end