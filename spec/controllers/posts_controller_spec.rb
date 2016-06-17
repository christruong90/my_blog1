require 'rails_helper'

def post_obj
  @post ||= FactoryGirl.create(:post)
end

RSpec.describe PostsController, type: :controller do

    describe "#new" do
      it "renders a new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "instantiates a new post instance variable" do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end
    end

    describe '#create' do
      context "with valid attributes" do
        def valid_request
          post :create, post:
          FactoryGirl.attributes_for(:post)
        end


        it "saves a record to the database" do
          count_before = Post.count
          valid_request
          count_after = Post.count
          expect(count_after).to eq(count_before + 1)
        end
        it "creates a new" do

        end
      end
    end

    describe "#edit" do
      it "renders the edit template" do
        get :edit, id: post_obj.id
        expect(response).to render_template(:edit)
      end
    end

    describe "update" do
      context "with valid attributes" do
        # let(:post) {FactoryGirl.create(:post)}
        def valid_request
          patch :update, id: post_obj.id, post:
          {title: "new valid title"}
        end

        it "updates the record in the database" do
          valid_request
          expect(post_obj.reload.title).to eq("new valid title")
        end
      end
    end

    describe "show" do
      # the `before` defines a block that gets executed before every example
      before do
        get :show, id: post_obj.id
      end

      it "renders the show template" do
        expect(response).to render_template(:show)
      end

      it "sets an instance variable to the campaign with the passed id" do
        expect(assigns(:post)).to eq(post_obj)
      end

    end

    describe "index" do
      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "sets 'products' instance variable to all products in the DB" do
        poster_1 = FactoryGirl.create(:post)
        poster_2 = FactoryGirl.create(:post)
        get :index

        expect(assigns(:posts)).to(
          match_array([poster_1, poster_2])
        )
        # expect().to(
        #   match_array([poster_1, poster_2])
        # )
      end
    end
end
