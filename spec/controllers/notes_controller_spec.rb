require 'spec_helper'

describe NotesController do
  let(:user) { User.create! name: "testuser"}
  let(:book) { Book.create! title: "Ruby" }

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', {book_id: book.id}
      response.should be_success
    end

    it "should assigns @book" do
      get :new, {book_id: book.id }

      assigns[:book].should eq(book)
    end
  end

  describe "POST 'create'" do
    it "should redirect to book#show" do
      post :create, { note: { page: 100, note: 'note content' }, book_id: book.id }

      response.should redirect_to(book)
    end

    it "should assigns @book" do
      post :create, { note: { page: 100, note: 'note content' }, book_id: book.id }

      assigns[:book].should eq(book)
    end

    it "should append a note to @book#notes" do
      expect {
        post :create, { note: { page: 100, note: "note content" }, book_id: book.id }
      }.to change(book.notes, :count).by(1)
    end

    it "should append a note to current_user#notes" do
      expect {
        post :create, { note: { page: 100, note: "note content"}, book_id: book.id }, {user_id: user.id}
      }.to change(user.notes, :count).by(1)
    end
  end

  describe "edit" do
    let(:note) {Note.create book: book, user: user, page: 10, note: 'saved note'}

    describe "GET 'edit'" do
      before do
        get :edit, {book_id: book.id, id: note.id}
      end

      it "return http success" do
        response.should be_success
      end

      it "should assigns @book and @note" do
        assigns[:book].should eq(book)
        assigns[:note].should eq(note)
      end

      it "should render edit template" do
        response.should render_template(:edit)
      end
    end

    describe "PUT 'update'" do
      it "should updates the note" do
        Note.any_instance.should_receive(:update_attributes)
        put :update, {book_id: book.id, id: note.id, note: {note: 'new note'}}

      end

      it "shoud redirect to book#show" do
        put :update, {book_id: book.id, id: note.id, note: {note: 'new note'}}

        response.should redirect_to(book)
      end
    end
  end
end
