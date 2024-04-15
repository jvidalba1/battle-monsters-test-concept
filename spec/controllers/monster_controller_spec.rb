require 'rails_helper'

RSpec.describe MonstersController, type: :controller do
  def create_monsters
    FactoryBot.create_list(:monster, 1)
  end

  it 'should get all monsters correctly' do
    create_monsters
    get :index
    response_data = JSON.parse(response.body)['data']

    expect(response).to have_http_status(:ok)
    expect(response_data[0]['name']).to eq('My monster Test')
  end

  it 'should get a single monster correctly' do
    create_monsters
    get :show, params: { id: 1 }
    response_data = JSON.parse(response.body)['data']

    expect(response).to have_http_status(:ok)
    expect(response_data['name']).to eq('My monster Test')
  end

  it 'should get 404 error if monster does not exists' do
    get :show, params: { id: 99 }

    expect(response).to have_http_status(:not_found)
    expect(JSON.parse(response.body)['message']).to eq('The monster does not exists.')
  end

  it 'should create a new monster' do
    monster_attributes = FactoryBot.attributes_for(:monster)

    post :create, params: { monster: monster_attributes }

    response_data = JSON.parse(response.body)['data']

    expect(response).to have_http_status(:created)
    expect(response_data['name']).to eq('My monster Test')
  end

  it 'should update a monster correctly' do
    create_monsters
    monster_attributes = FactoryBot.attributes_for(:monster)
    put :update, params: { id: 1, monster: monster_attributes }

    expect(response).to have_http_status(:ok)
  end

  it 'should fail update when monster does not exist' do
    monster_attributes = FactoryBot.attributes_for(:monster)
    put :update, params: { id: 99, monster: monster_attributes }

    expect(response).to have_http_status(:not_found)
    expect(JSON.parse(response.body)['message']).to eq('The monster does not exists.')
  end

  it 'should delete a monster correctly' do
    create_monsters
    delete :destroy, params: { id: 1 }

    expect(response).to have_http_status(:see_other)
  end

  it 'should fail delete when monster does not exist' do
    delete :destroy, params: { id: 99 }

    expect(response).to have_http_status(:not_found)
    expect(JSON.parse(response.body)['message']).to eq('The monster does not exists.')
  end

  context 'Importing CSV' do
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join(file_path), file_ext) }

    context 'when file is imported successfully' do
      let(:file_path) { 'spec/files/test_monsters.csv' }
      let(:file_ext) { 'text/csv' }

      it 'saves all the CSV rows into the database' do
        expect {
          post :import, params: { file: file }
        }.to change(Monster, :count).by(5)
      end

      it 'returns created status code' do
        post :import, params: { file: file }

        expect(response).to have_http_status(:created)
      end

      it 'returns a successfully message' do
        post :import, params: { file: file }

        expect(response_json(response)['message']).to eq('Records were imported successfully.')
      end
    end

    context 'when csv file with inexistent columns' do
      let(:inexistent_column_name) { 'inexistent_column' }
      let(:file_path) { 'spec/files/test_monsters_inexistent_column.csv' }
      let(:file_ext) { 'text/csv' }

      it 'returns a bad request code' do
        post :import, params: { file: file }

        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a specific message error' do
        post :import, params: { file: file }

        expect(
          response_json(response)['message']
        ).to eq("unknown attribute '#{inexistent_column_name}' for Monster.")
      end

      it 'does not save any record in the database' do
        expect {
          post :import, params: { file: file }
        }.to change(Monster, :count).by(0)
      end
    end

    context 'when import file with different extension' do
      let(:file_path) { 'spec/files/test_monsters.oelo' }
      let(:file_ext) { 'text/oelo' }

      it 'returns a specific error message' do
        post :import, params: { file: file }

        expect(
          response_json(response)['message']
        ).to eq('File should be csv.')
      end

      it 'returns a bad request code' do
        post :import, params: { file: file }

        expect(response).to have_http_status(:bad_request)
      end

      it 'does not save any record in the database' do
        expect {
          post :import, params: { file: file }
        }.to change(Monster, :count).by(0)
      end
    end

    context 'when there is no file' do
      let(:file) { 'no file' }

      it 'returns a specific error message' do
        post :import, params: { file: file }

        expect(
          response_json(response)['message']
        ).to eq('Please, provide a file.')
      end

      it 'returns a bad request code' do
        post :import, params: { file: file }

        expect(response).to have_http_status(:bad_request)
      end

      it 'does not save any record in the database' do
        expect {
          post :import, params: { file: file }
        }.to change(Monster, :count).by(0)
      end
    end
  end
end
