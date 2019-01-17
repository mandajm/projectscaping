require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_deputy_emails(deputy_page)           #On récupère l'email d'un député depuis sa page profil
	doc = Nokogiri::HTML(open(deputy_page))	
	doc.css('a').select{  |link| if link.to_s.include?("mailto") 
		lien = link.text
		return lien
		end
		}
end
p get_deputy_emails("https://www.nosdeputes.fr/berangere-abba")


def get_dep_name							#On récupère un array avec "noms, prénoms" de tous les députés
	doc = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
	dep_names =[]
	doc.css('span[class = list_nom]').each{  |name| 
		dep_names<< name.text.to_s[7...-4]
		}
		return dep_names
end
get_dep_name




@dep_webpages =[]
@dep_first_names =[]
@dep_last_names =[]
def get_first_last_name
	tableau = get_dep_name					#On crée un array pour les prénoms, un array pour les noms
	tableau.each {|name| 					#et un array pour les url des pages profils de tous les députés
		a = name.split
		first_name = a[1]
		last_name = a[0][0...-1]
		webpage = "https://www.nosdeputes.fr/#{first_name}-#{last_name}"   #on crée l'url du la page de chaque député
		@dep_webpages<<webpage  			# array des emails
		@dep_first_names<< first_name 		# array des prénoms
		@dep_last_names<< last_name  		# array des noms
	}
end
get_first_last_name

p get_deputy_emails(@dep_webpages[199])




@table_deputes = []

def get_dep_complete
	doc = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
		
		i=0	
		@dep_webpages.each { |page|  
			@table_deputes << { 'first_name' => @dep_first_names[i] , 'last_name' => @dep_last_names[i] #, "email :" => get_deputy_emails(page)  		
				}	
		i+=1
		}
end

get_dep_complete
@table_deputes
