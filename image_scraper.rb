require './config/environment.rb'

class ImageScraper

  def initialize(species)
    @species = species.sub(' SPECIES', '')
    @agent = Mechanize.new
  end

  def find_image
    begin
      search
      if no_results?
        return nil
      elsif page_found?
        image = scrape_image
        # Image.create(species: @species, image: image)
        return image
      elsif common_name?
        link = choose_from_options
        @agent.get("http://plants.usda.gov/java/#{link}")
        image = scrape_image
        # Image.create(species: @species, image: image)
        return image
      end
    rescue
      return nil
    end
  end

  def no_results?
    @agent.page.at(".hdrblkbold").text == " No Data Found "
  end

  def page_found?
    @agent.page.at(".breadcrumb").text.include?("Plant Profile")
  end

  def common_name?
    @agent.page.at(".hdrblkbold").text.include?("Common Name")
  end

  def search
      @agent.get("http://plants.usda.gov/java/")
      @agent.page.form_with(name: "namserch") do |form|
        form.mode = "comname"
        form.keywordquery = @species
      end.submit
  end

  def choose_from_options
    @agent.page.search(".rowon").each do |row|
      if row.search("td")[1].text.upcase == @species
        return @x = row.search("td")[0].at("a").attr('href')
      end
    end
  end

  def scrape_image
    image_path = @agent.page.search("a [title='click to view a large image']")[0].at("img")["src"]
    image_url = "http://plants.usda.gov" + image_path.sub('/thumbs/', '/pubs/').sub('_thp', '_php').sub('_tvp', '_pvp')
    return image_url
  end

  def save_image_to_database(image)
    Image.create(species: @species, image: image)
  end

end

puts ImageScraper.new("EASTERN COTTONWOOD").find_image