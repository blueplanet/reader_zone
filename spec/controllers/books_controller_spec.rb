# encoding: utf-8
require 'spec_helper'

describe BooksController do
  before(:all) do
    Book.delete_all
  end

  let(:user) {User.create name: 'testuser'}
  let(:user_other) {User.create name: 'user_other'}
  let(:book) { 
    Book.delete_all

    book = Book.create( image_url: "test.png", title: "Ruby", description: "I's a language", created_by: user)

    @n1 = book.notes.build page: 1, note: 'note1', user: user
    book.notes.build page: 1, note: 'note11', user: user_other
    @n2 = book.notes.build page: 2, note: 'note2', user: user

    book.save
    book
  }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "should assign @books" do
      Book.delete_all
      book = Book.create image_url: "test.png", title: "Ruby", description: "This is a language"

      get 'index'

      assigns(:books).should eq([book])
    end

    it "should render index template" do
      get 'index'
      response.should render_template("index")
    end
  end

  describe "GET 'my" do
    before do
      get 'my', {id: book.id}, {user_id: user.id}
    end

    it "return http success" do
      response.should be_success
    end

    it "should assigns @book" do
      assigns[:book].should eq(book)
    end

    it "should assigns @notes" do
      assigns[:notes].should eq([@n1, @n2])
    end

    it "should display note only for me" do
      assigns[:notes].length.should == 2
      assigns[:notes].all? { |note| note.user.should eq(user)}
    end

    it "should render my template" do
      response.should render_template("my")
    end
  end

  describe "GET 'show'" do
    before do
      get 'show', {id: book.id}
    end

    it "return http success" do
      response.should be_success
    end

    it "should assigns @book" do
      assigns[:book].should eq(book)
    end

    it "should render show template" do
      response.should render_template("show")
    end
  end

  describe "GET 'new'" do
    it "return http success" do
      get 'new'

      response.should be_success
    end

    it "should assigns @book" do
      get 'new'

      assigns[:book].should be_new_record
    end

    it "should render new template" do
      get 'new'

      response.should render_template("new")
    end
  end

  describe "POST 'create'" do
    context "with valid params" do
      it "creates a new book" do
        expect {
          post :create, {book: {"title" => 'ruby 1', "image_url" => '.../test.png', 'description' => 'ruby is ...', "created_by_id" => user.id.to_param }}
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created Book as @book" do
        post :create, {book: {title: 'ruby', image_url: '.../test.png', description: 'ruby is ...'}}

        assigns[:book].should be_a(Book)
        assigns[:book].should be_persisted
      end

      it "redirect to the created book" do
        post :create, {book: {title: 'ruby 2', image_url: '.../test.png', description: 'ruby is ...'}}

        response.should redirect_to(book_path(assigns[:book]))
      end
    end

    context "with invalid params" do
      it "assigns a created but unsaved book as @book" do
        post :create, {book: {image_url: '.../test.png', description: 'ruby is ...'}}

        assigns[:book].should be_a(Book)
        assigns[:book].should_not be_persisted
        assigns[:book].errors.should_not be_nil
      end

      it "re-renders the 'new' template" do
        post :create, {book: {image_url: '.../test.png', description: 'ruby is ...'}}

        response.should render_template(:new)
      end
    end
  end

  describe "GET 'edit'" do
    context "with valid params" do
      it "should assigns @book" do
        get :edit, {id: book.id}, {user_id: user.id}

        assigns[:book].should eq(book)
      end

      it "rendered 'edit' template" do
        get :edit, {id: book.id}, {user_id: user.id}

        response.should render_template(:edit)
      end
    end

    context "without user_id" do
      it "redirect to 'show'" do
        get :edit, id: book.id

        response.should redirect_to(book)
      end
    end

    context "with other user" do
      it "redirect to 'show'" do
        get :edit, {id: book.id}, {user_id: user_other.id}

        response.should redirect_to(book)
      end
    end
  end

  describe "PUT 'update'" do
    context "with valid params" do
      it "updates the requested book" do
        Book.any_instance.should_receive(:update_attributes).with("title" => "Ruby Programing")
        put :update, {id: book.id, book: {title: 'Ruby Programing'}}, {user_id: book.created_by_id}
      end

      it "assign the updated book to @book" do
        put :update, {id: book.id, book: {title: 'Ruby Programing'}}
        
        assigns[:book].should eql(book)
      end

      it "redirect to book" do
        put :update, {id: book.id, book: {title: 'Ruby Programing'}}

        response.should redirect_to(book)
      end
    end

    context "with invalid params" do
      it "assign the requested book" do
        put :update, {id: book.id, book: {title: ""}}, {user_id: user.id}

        assigns[:book].should eq(book)
      end

      it "re-renders 'edit' templates" do
        put :update, {id: book.id, book: {title: ""}}, {user_id: user.id}

        response.should render_template(:edit)
      end
    end

    context "without user_id" do
      it "redirect to 'show'" do
        put :update, {id: book.id, book: {"title" => "new title"}}, {user_id: user_other.id }

        book.reload
        book.title.should_not eq "new title"
        response.should redirect_to(book)
      end
    end
  end
end
