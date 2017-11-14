class TestQuestionsController < ApplicationController

  def index
    test = Test.find params[:test_id]
    render json: test.test_questions
  end

  def show
    question = TestQuestion.find params[:id]
    render json: question
  end

  def create
    test = Test.find params[:test_id]
    params[:questions].each do |question|
      newQuestion = TestQuestion.new number: question[:number],
                                     description: question[:description],
                                     answer: question[:answer],
                                     value: question[:value],
                                     kind: question[:kind],
                                     comment: question[:comment],
                                     test: test
      if question[:alternatives]
        question[:alternatives].each do |alternative|
          TestAlternative.create text: alternative[:text], correct: alternative[:correct], test_question: newQuestion
        end
      end

      newQuestion.save!
    end
  end

  def update
    params[:questions].each do |quest|
      question = TestQuestion.find quest[:id]
      question.description = quest[:description]
      question.answer = quest[:answer]
      question.value = quest[:value]
      question.comment = quest[:comment]

      if quest[:test_alternatives]
        quest[:test_alternatives].each do |alter|
          alternative = TestAlternative.find alter[:id]
          alternative.text = alter[:text]
          alternative.correct = alter[:correct]
          alternative.save!
        end
      end

      question.save!
    end
  end

  def destroy
    render json: TestQuestion.find(params[:id]).destroy
  end
  
end