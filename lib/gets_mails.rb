

require 'nokogiri'  #appelle de la gem dans Gemfile


require 'rubygems' #gems neccessaire

require 'open-uri' #pour ouvrir l'URL



def get_townhall_email(mairie_url)
	doc = Nokogiri::HTML(open(mairie_url))

     doc.xpath("//td").select do |lestd|
        p lestd.text if lestd.text.include?("@")
     end	
end


get_townhall_email("http://annuaire-des-mairies.com/95/vaureal.html")
