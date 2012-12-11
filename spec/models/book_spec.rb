require 'spec_helper'

describe Book do
  describe "#save" do
    let(:book) { Book.new title: 'ruby', image_url: 'test.png', description: 'ruby is ....'}

    context "with invalid params" do
      # it "without title" do
      #   book.title = nil
      #   book.save

      #   book.should_not be_valid
      # end

      # it "with title has duplication" do
      #   Book.delete_all
      #   Book.create title: 'ruby'

      #   book.save

      #   book.should_not be_valid
      # end

    end
  end
end