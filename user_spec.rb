require 'byebug'
require './user'

$debug_flag = false

def with_debug_flag
  $debug_flag = true
  yield
ensure
  $debug_flag = false
end

RSpec.describe User do
  before :all do
    @white = User.new(name: "Mr White", email: "white@example.com")
    @blue = User.new(name: "Mr Blue", email: "blue@example.com")
    @blonde = User.new(name: "Mr Blonde", email: "blonde@example.com")
    @pink= User.new(name: "Mr Pink", email: "pink@example.com")
  end

  describe "instantiation" do
    it "should set the name and email attributes based on the values passed" do
      expect(@white.name).to eq "Mr White"
      expect(@white.email).to eq "white@example.com"
    end

    it "should add the user to the user store" do
      expect(User.all_users.size).to eq 4
      User.new(name: "Mr Brown", email: "brown@example.com")
      expect(User.all_users.size).to eq 5
    end
  end

  describe "instance method" do
    describe "#add_friend" do
      before :all do
        [@white, @blue, @blonde].each do |friend|
          @pink.add_friend(friend.name)
        end
      end

      describe "where user doesn't exist for the name passed" do
        it "should not add a friend" do
          expect(@blue.friends.size).to eq 1
          @blue.add_friend("Mr Orange")
          expect(@blue.friends.size).to eq 1
          $debug_flag = false
        end
      end

      describe "where user exists for the name passed" do
        it "should create a friendship for the name passed" do
          expect(@blue.is_friend?("Mr Blonde")).to be_falsey
          @blue.add_friend("Mr Blonde")
          expect(@blue.is_friend?("Mr Blonde")).to be_truthy
        end

        it "should increase the total number of friends by 1" do
          orig_count = @blue.friends.size
          #with_debug_flag{ @blue.add_friend("Mr Blonde") }  # Uncomment this line
          @blue.add_friend("Mr Blonde")                       # Comment out this line
          expect(@blue.friends.size).to eq orig_count+1
        end
      end
    end
  end
end
