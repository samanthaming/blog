require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user)      { FactoryGirl.create(:user) }
  let(:blog_post) { FactoryGirl.create(:post)}
  let(:owned_blog_post) {FactoryGirl.create(:post, user: user)}

  describe "#new" do
    context "when user is signed in" do
      before { signed_in(user) }

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "instantiates a new Post object and assigns it to @post" do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end
    end

  end

  describe "#create" do

    context "user is signed in" do

      before { request.session[:user_id] = user.id }


      context "with valid attributes" do
        def valid_request
          post :create, post: { title: "valid title hi",
            body: "i am the body"}
          end
          it "creates a record in the DB" do
            before_count = Post.count
            valid_request
            after_count = Post.count
            expect(after_count - before_count).to eq(1)
          end
          it "redirects to the 'show' page" do
            valid_request
            expect(response).to redirect_to(post_path(Post.last))
          end
          it "sets a flash notice message" do
            valid_request
            expect(flash[:notice]).to be
          end
        end

        context "with invalid attributes" do
          def invalid_request
            post :create, post: {title: "short"}
          end
          it "doesn't create a record in the DB" do
            before_count = Post.count
            invalid_request
            after_count = Post.count
            expect(after_count - before_count).to eq(0)
          end
          it "renders the 'new' template" do
            invalid_request
            expect(response).to render_template(:new)
          end
          it "sets a flash alert message" do
            invalid_request
            expect(flash[:alert]).to be
          end
        end


    end

    context "user is not signed in" do
      before { not_authenticated }

      it 'redirect to sign in page' do
        post :create, {}
        expect(response).to redirect_to(new_session_path)
      end

      # it 'flash notice message' do
      #   post :create, {}
      #   expect(flash[:alert]).to be ##not really working
      # end

    end


  end

  describe "#show" do
    before do
      get :show, id: blog_post
    end
    it "finds the object by its id and assigns it to the @post instance variable" do
      expect(assigns(:post)).to eq(blog_post)
    end
    it "it renders the show template" do
      expect(response).to render_template(:show)
    end
    it "raises an error if the id passed doesn't match a record in the DB" do
      expect{get :show, id: 3847293847293}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "fetches all records and assigns it to the @posts instance variable" do
      c = FactoryGirl.create(:post)
      c1 = FactoryGirl.create(:post)
      get :index
      expect(assigns(:posts)).to eq([c1,c])
    end
  end

  describe "#edit" do
    before do
      signed_in(user)
      owned_blog_post
      get :edit, id: owned_blog_post
    end
    context 'when the user is signed in and owner of that post' do
      it "renders the 'edit' template" do
        expect(response).to render_template(:edit)
      end
      it "finds the object by its id and assigns it to the @post instance variable" do
        expect(assigns(:post)).to eq(owned_blog_post)
      end
    end
  end

  describe "#update" do


    context 'when user is signed in and owner of that post' do

      before do
        request.session[:user_id] = user.id #login user
      end

      context "with valid attributes" do
        before do
          patch :update, id: owned_blog_post, post: {title: "new valid title"}
        end
        it "updates the record with new parameter(s)" do

          expect(owned_blog_post.reload.title).to eq("new valid title")
        end
        it "redirects to the 'show' page" do
          expect(response).to redirect_to(post_path(owned_blog_post))
        end
        it "sets a flash notice message" do
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do
        def invalid_request
          patch :update, id: owned_blog_post, post: {title: "short",body: "i am body"}
        end
        it "doesn't update the record" do
          before_body = owned_blog_post.body
          invalid_request
          expect(owned_blog_post.reload.body).to eq(before_body)
        end
        it "renders the 'edit' template" do
          invalid_request
          expect(response).to render_template(:edit)
        end
        it "sets a flash alert message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end

    context 'when user is not signed in' do
      it "redirects to the sign in page" do
        not_authenticated
        post :create, {}
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

  describe "#destroy" do


    def destroy_request
      request.session[:user_id] = user.id #signed in
      delete :destroy, id: owned_blog_post
    end
    context 'when user is signed in and owner of post' do

      it "removes the record from the DB" do
        owned_blog_post
        before_count = Post.count
        destroy_request
        after_count = Post.count
        expect(before_count - after_count).to eq(1)
      end
      it "redirects to the 'index' page" do
        owned_blog_post
        destroy_request
        expect(response).to redirect_to(posts_path)
      end
      it "sets a flash notice message" do
        # owned_blog_post
        destroy_request
        expect(flash[:notice]).to be
      end

    end

    context 'when user is signed in but not owner'  do
      it 'redirects to session new page' do
        request.session[:user_id] = user.id
        delete :destroy, id: blog_post
        expect(response).to redirect_to(root_path)
      end
    end


  end




end
