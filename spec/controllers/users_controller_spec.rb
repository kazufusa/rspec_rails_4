require 'spec_helper'

describe UsersController do
  describe 'user access' do
    before :each do
      @user = create :user
      session[:user_id] = @user.id
    end

    describe 'GET #index' do
      it 'collect users into @user' do
        user = create :user
        get :index
        expect(assigns[:users]).to match_array [@user, user]
      end

      it 'renders to :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    it 'GET #new denied access' do
      get :new
      expect(response).to redirect_to root_url
    end

    it 'POST #create denied access' do
      post :create
      expect(response).to redirect_to root_url
    end

  end
end
