FactoryGirl.define do
  factory :test_question do
    number 1
    description "MyText"
    answer "MyText"
    value "9.99"
    kind false
    comment "MyText"
    attachable nil
    test nil
  end
end
