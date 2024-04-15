FactoryBot.define do
    factory :monster do
      name { 'My monster Test' }
      attack { 20 }
      defense { 40 }
      hp { 70 }
      speed { 10 }
      image_url { 'https://example.com/image.jpg' }
    end
end
