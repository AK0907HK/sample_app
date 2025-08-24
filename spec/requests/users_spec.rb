require 'rails_helper'
 
RSpec.describe "Users", type: :request do
  describe "GET /signup" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:ok)
    end

    context '有効な値の場合' do
      let(:user_params) { { user: { name: 'Example User',
                                 email: 'user@example.com',
                                 password: 'password',
                                 password_confirmation: 'password' } } }

      it '登録されること' do
        expect {
         post users_path, params: user_params
         }.to change(User, :count).by 1
      end

      it 'users/showにリダイレクトされること' do
        post users_path, params: user_params
        user = User.last
        expect(response).to redirect_to user
      end

      it 'ログイン状態であること' do
        post users_path, params: user_params
        expect(logged_in?).to be_truthy
      end
    end
  end  
end 