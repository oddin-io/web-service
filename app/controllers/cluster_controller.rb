class ClusterController < ApplicationController
    def index
        clusters =  Presentation.find(params[:presentation_id]).questions if params[:presentation_id]        
        render json: clusters
    end
    
    def destroy
        render json: ClusterQuestion.find(params[:id]).destroy
    end
end
