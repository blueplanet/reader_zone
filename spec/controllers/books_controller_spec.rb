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

    book = Book.create( image_url: "test.png", title: "Ruby", description: "I's a language")

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
          post :create, {book: {title: 'ruby 1', image_url: '.../test.png', description: 'ruby is ...'}}
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
      it "assigns a created but unsaved book as @book"

      it "re-renders the 'new' template"
    end
  end
end
