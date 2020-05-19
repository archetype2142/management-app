module Api
  module V1
    class StatesController < ::ApplicationController
      def show
        country = params[:country_name].to_s
        array = Country.find_by(name: country).states.pluck(:name)
 
        render json: Hash[(0...array.size).zip array] 
      end
    end
  end
end