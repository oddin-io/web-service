FactoryGirl.define do
  factory :test_question do
    number 1
    question "MyText"
    answer "MyText"
    file ""
    value "9.99"
    kind false
    test nil
  end
end
