require 'rails_helper'

RSpec.describe "Exercises API", type: :request do
  let!(:user) { create(:user) }
  let!(:exercise_category) { create(:exercise_category) }
  let!(:muscle_groups) { create_list(:muscle_group, 3) }
  let!(:exercises) { create_list(:exercise, 10, user: user, created_by_user: true, exercise_category: exercise_category, muscle_groups: muscle_groups) }

  let(:json) { JSON.parse(response.body) }

  before do
    post '/api/v1/auth/sign_in', params: { email: user.email, password: user.password }
    @token = response.headers['authorization']
  end

  describe "Get /exercises" do
    it "returns all exercises" do
      get "/api/v1/exercises", headers: { "Authorization" => @token }
      expect(json).not_to be_empty
      expect(json.size).to eq(exercises.count)
    end
  end

  describe "Get /exercises/:id" do
    let(:specific_exercise) { exercises.first }
    it "returns an exercise" do
      get "/api/v1/exercises/#{specific_exercise.id}", headers: { "Authorization" => @token }
      expect(json).not_to be_empty
      expect(json["id"]).to eq(specific_exercise.id)
    end
  end

  describe "POST /api/v1/exercises" do
    it "creates a new exercise with one muscle group" do
      expect {
        post "/api/v1/exercises",
             headers: { "Authorization" => @token },
             params: {
               exercise: {
                 name: "New Exercise",
                 description: "Description",
                 exercise_category_id: exercise_category.id,
                 muscle_group_ids: [muscle_groups.first.id]
               }
             },
             as: :json
      }.to change(Exercise, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(json["name"]).to eq("New Exercise")
    end

    it "creates a new exercise with multiple muscle groups" do
      expect {
        post "/api/v1/exercises",
             headers: { "Authorization" => @token },
             params: {
               exercise: {
                 name: "New Multi-Muscle Group Exercise",
                 description: "Multi-muscle group description",
                 exercise_category_id: exercise_category.id,
                 muscle_group_ids: [muscle_groups.first.id, muscle_groups.second.id]
               }
             },
             as: :json
      }.to change(Exercise, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json["name"]).to eq("New Multi-Muscle Group Exercise")
    end
  end

  describe "DELETE /api/v1/exercises/:id" do
    let!(:second_user) { create(:user) }
    let!(:new_exercise) { create(:exercise, user: second_user, created_by_user: true, exercise_category: exercise_category, muscle_groups: muscle_groups) }
    it "deletes an exercise" do
      exercise = exercises.first
      Rails.logger.debug("Exercise for inspection: #{exercise.inspect}")
      expect {
        delete "/api/v1/exercises/#{exercise.id}", headers: { "Authorization" => @token }
      }.to change(Exercise, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it "does not delete an exercise if the user is not the creator" do
      expect {
        delete "/api/v1/exercises/#{new_exercise.id}", headers: { "Authorization" => @token }
      }.to change(Exercise, :count).by(0)
      expect(response).to have_http_status(:forbidden)
    end
  end
end
