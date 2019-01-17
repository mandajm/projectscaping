require 'nokogiri'  #appelle de la gem dans Gemfile


require 'rubygems' #gems neccessaire

require 'open-uri' #pour ouvrir l'URL

hash = {}
doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def array(page)
array_des_cours = [] #creation de tableau de stocage dea cours
 page.css('a[class = price]').each do  |taux|  # incrementation des tableau
  array_des_cours<< taux.text #rempissage du tableau
 end

   array_des_monnaies = []
    page.css('a[class = link-secondary]').each do |monnaie| 
      array_des_monnaies<< monnaie.text
    end
    hash_des_cours = Hash[array_des_monnaies.zip(array_des_cours)]
    
    hash_des_cours.each do |i| # affichage d'un hash
      p i
    end
  end

  array(doc)  #appel à la methode


