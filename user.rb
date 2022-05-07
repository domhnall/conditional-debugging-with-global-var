class User
  @@all_users = []

  attr_reader :name, :email, :friends

  def initialize(name: nil, email: nil)
    @name = name
    @email = email
    @friends = []
    @@all_users << self
  end

  def add_friend(friend_name)
    byebug if $debug_flag
    return unless friend = @@all_users.find{ |u| u.name==friend_name }
    return if is_friend?(friend_name)
    @friends << friend
    friend.add_friend(name)
  end

  def remove_friend(friend_name)
    return unless friend = @@all_users.find{ |u| u.name==friend_name }
    return unless is_friend?(friend_name)
    @friends.delete(friend)
    friend.remove_friend(name)
  end

  def total_friends
    @friends.size
  end

  def is_friend?(friend_name)
    @friends.any?{ |u| u.name==friend_name }
  end

  def self.all_users
    @@all_users
  end
end
