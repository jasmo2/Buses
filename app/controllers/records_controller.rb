class RecordsController < ApplicationController
    def new
    end
    def create
        register = Register.new()
    end
    private
    def bus_params
        params.require(:bus).permit(:time,:quantity,:register_type)
    end
end