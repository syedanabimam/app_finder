class PagesController < ApplicationController
    require 'open-uri'
    require 'json'
    
    def index
        
    end
    
    def new
      @app_finder = Page.new
    end
    
    #Search Method: Gets search param, returns the JSON response and returns the result in the JSON format
    def search
      @app_finder = params[:search_id]

      @result_json = JSON.parse(open("https://itunes.apple.com/lookup?id=#{@app_finder}").read())
      result_count =  @result_json["resultCount"]
      if result_count == 1
        @results = {}
        
        @results["appId"] = @result_json["results"][0]["bundleId"]
        @results["name"] = @result_json["results"][0]["trackName"]
        @results["publisher"] = @result_json["results"][0]["sellerName"]
        @results["currentVersion"] = @result_json["results"][0]["version"]
        @results["description"] = @result_json["results"][0]["description"]
        @results["currentVersionReleaseDate"] = @result_json["results"][0]["currentVersionReleaseDate"]
  
        @display_format =  @results.to_json
      else
        flash[:alert] = "Invalid Itunes App ID!"
        redirect_to root_path
      end
    end
    
    private

    # This private method whitelist the Search object params for it to be use in case when
    # RESTFUL resources are to be used in regards to controller
    def search_params
       params.require(:page).permit(:search_id, :commit)
    end
end
