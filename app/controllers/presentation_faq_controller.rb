class PresentationFaqController < ApplicationController
    def index
        faq =  Presentation.find(params[:presentation_id]).questions if params[:presentation_id]     
        render json: faq
    end

    def create
        presentation = Presentation.find params[:presentation_id]
        cluster = Cluster.find params[:cluster_id]
        person = current_person
        question = Question.new text: params[:text], anonymous: params[:anonymous] || false, created_at: DateTime.now,
        presentation: presentation, person: person, cluster: cluster, isfaq: true
        question.save!
        render json: question
    end

    def destroy
        render json: PresentationFaq.find(params[:id]).destroy
    end
end
