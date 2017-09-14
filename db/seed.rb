require_relative '../config/environment'


def get_artwork_from_api 
	json = RestClient.get('https://www.rijksmuseum.nl/api/en/collection/?key=nYs4EF23&format=json&ps=100')
	collection = JSON.parse(json)
end 

def parse(data)

	data['artObjects'].map do |obj| 
		{
		object_id: obj['id'],
		title: obj['title'],
		artist: obj['principalOrFirstMaker'],
		date: obj['longTitle'].split(", ").last,
		image_url: obj['webImage']['url']   # turn to ascii at some point 
		# get description 
		}

	end 

end 


raw_data = get_artwork_from_api
artworks_attrs = parse(raw_data) 

artworks_attrs.each {|attrs| Artwork.create(attrs)}


