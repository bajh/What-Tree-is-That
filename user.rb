class User

  def initialize(params)
    coords = params["latitude"] + ", " + params["longitude"]
    @geo_object = Geocoder.search(coords)
  end

  def zip_code
    @geo_object.first.address_components[7]["long_name"]
  end

  def borough
    @geo_object.first.address_components[3]["long_name"]
  end

  def building_num
    @geo_object.first.address_components[0]["long_name"]
  end

  def street
    @geo_object.first.address_components[1]["long_name"].upcase
  end

end