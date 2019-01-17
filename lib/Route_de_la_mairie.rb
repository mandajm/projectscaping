

require 'nokogiri'  #appelle de la gem dans Gemfile


require 'rubygems' #gems neccessaire

require 'open-uri' #pour ouvrir l'URL



def get_the_email_of_a_townhal_from_its_webpage (mairie_url)
	doc = Nokogiri::HTML(open(mairie_url))

	return doc.css('td')[7].text		#marche aussi avec : puts doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
										#marche presque avec : puts doc.xpath("//td").select { |lestd| lestd.text if lestd.text.include?("@")}
end

p get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")



def get_all_the_urls_of_val_doise_townhalls 
	doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
			array_des_sites = []
			doc.css('a[class = lientxt]').each{  |link|			 #ou aussi : doc.css('a').map { |link| link['href'] }
				lien = link['href']								 # doc.xpath('//a[@class = "lientxt"]/@href').each do |lien|
				lien[0]= ''
				url = "http://annuaire-des-mairies.com#{lien}"
				array_des_sites << url
				}
		return array_des_sites
end

get_all_the_urls_of_val_doise_townhalls



def get_the_emails_of_all_townhals_of_val_doise
	
	tableau_url = get_all_the_urls_of_val_doise_townhalls 
	tableau_emails_mairies = []
	tableau_url.each { |page_url|
		email_mairie = get_the_email_of_a_townhal_from_its_webpage(page_url)
		tableau_emails_mairies << email_mairie	
		}
	

	noms_villes = []
	doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	doc.css('a[class = lientxt]').each{  |name|   noms_villes << name.text	}
	

	hash_des_villes = Hash[noms_villes.zip(tableau_emails_mairies)]
	p hash_des_villes
end

get_the_emails_of_all_townhals_of_val_doise

