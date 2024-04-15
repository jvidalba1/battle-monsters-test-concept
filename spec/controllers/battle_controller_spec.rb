require 'rails_helper' 

RSpec.describe BattlesController, type: :controller do
    before(:each) do
        @monster1 = FactoryBot.create(:monster,
          name: 'My monster Test 1',
          attack: 40,
          defense: 20,
          hp: 50,
          speed: 80,
          imageUrl: 'https://example.com/image.jpg'
        )

        # Please include additional monsters here for testing purposes.
    end
    
    def create_battles
        FactoryBot.create_list(:battle, 2)
    end

    it 'should get all battles correctly' do
        create_battles
        get :index
        response_data = JSON.parse(response.body)['data']
    
        expect(response).to have_http_status(:ok)
        expect(response_data.count).to eq(2)
    end

    it 'should create battle with bad request if one parameter is null' do
      skip 'add test'
    end

    it 'should create battle with bad request if monster does not exists' do
      skip 'add test'
    end

    it 'should create battle correctly with monsterA winning' do
      skip 'add test'
    end

    it 'should create battle correctly with monsterB winning with equal defense and monsterB higher speed' do
      skip 'add test'
    end

    it 'should delete a battle correctly' do
      skip 'add test'
    end

    it 'should fail delete when battle does not exist' do
      skip 'add test'
    end
end
