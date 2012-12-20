require 'spec_helper'

describe Book do
  before(:all) do
    Book.delete_all

  end

  describe "#save" do
    let!(:book) { 
      Book.new title: 'ruby', image_url: 'test.png', description: 'ruby is ....'
    }

    context "with valid params" do
      it "save created_by" do
        user = User.create name: 'testuser'
        book.title = 'test111'
        book.created_by = user

        book.should be_valid
        book.created_by.name.should eq user.name
      end
    end

    context "with invalid params" do
      it "without title" do
        book.title = nil

        book.should_not be_valid
      end

      it "with title has duplication" do
        Book.delete_all
        Book.create title: 'ruby'

        book.should_not be_valid
      end
    end
  end
end