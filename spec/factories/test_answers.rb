FactoryGirl.define do
  factory :test_answer do
    answer "MyText"
    person nil
    test_question nil
    test_alternative nil
  end
end
