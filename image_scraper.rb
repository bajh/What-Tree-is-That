require './config/environment.rb'

class ImageScraper

  def initialize(species)
    @species = species
    @agent = Mechanize.new
  end

  def find_image
    begin
      @agent.get("http://plants.usda.gov/java/")
      @agent.page.form_with(name: "namserch") do |form|
        form.mode = "comname"
        form.keywordquery = @species
      end.submit
      if @agent.page.search("a [title='click to view a large image']").length == 0
        if choose_from_options
          scrape_image
        else
          return nil
        end
      else
        return scrape_image
      end
    rescue
      return nil
    end
  end

  def choose_from_options
    binding.pry
    @agent.page.search(".rowon").each do |row|
      if row.search("td")[1].text.upcase == @species
        row.search("td")[0].at("a").click
        return scrape_image
      end
    end
    return nil
  end



  def scrape_image
    image_path = @agent.page.search("a [title='click to view a large image']")[0].at("img")["src"]
    image_url = "http://plants.usda.gov" + image_path.gsub('/thumbs/', '/large/').gsub('_thp', '_lhp').gsub('_tvp', '_lvp')
    return image_url
  end

end