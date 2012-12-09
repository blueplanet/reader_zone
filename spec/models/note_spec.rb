require "spec_helper"

describe Note do
  context "scoped of_user" do
    let(:book) {Book.create title: 'ruby'}
    let(:user) {User.create name: 'testuser'}
    let(:user_other) {User.create name: 'user_other'}

    before do
      Note.delete_all

      @n1 = Note.create book: book, page: 101, note: '101 note', user: user
      Note.create book: book, page: 102, note: 'note user_other 102', user: user_other
      @n2 = Note.create book: book, page: 102, note: '102 note', user: user
    end

    it "should display notes only owner of user" do
      notes = Note.of_user(user)

      notes.should eq([@n1, @n2])
    end
  end
end