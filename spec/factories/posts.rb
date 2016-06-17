FactoryGirl.define do
  factory :post do
    # we use sequence when we want to have one of our record be unique so we
    # have an access to a counter variable `n` which we can use to generate
    # the unique field.
    sequence(:title) {|n| "#{Faker::Commerce.product_name}-#{n}" }
    body             { Faker::Lorem.paragraph         }
  end
end
