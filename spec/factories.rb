#  id                     :integer          not null, primary key
#  username               :string           default(""), not null
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email  
FactoryGirl.define do
  factory :user do
    username    "John"
    email     "jasmo2@coonatra.org"
    trait :editor do
      username   "John_Editor"
      email "male@coonatra.org"
      role "editor"
      password "santiago"
    end
    trait :reader do
      username   "John_Reader"
      email "he@coonatra.org"
      role "reader"
      password "santiago"
    end
    trait :admin do
      username   "John_Admin"
      email "male@coonatra.org"
      role "admin"
      password "santiago"
    end

  end
end