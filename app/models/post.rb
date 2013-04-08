class Post < ActiveRecord::Base
  validate :body_cant_have_words_foo_or_bar, :on => :create

  attr_accessible :body, :title, :status, :likes
  has_many :comments
  has_many :likes
  belongs_to :user
  
  validates :body, :presence => true
  validates :body, :uniqueness => true


  def body_cant_have_words_foo_or_bar

  	if (body.downcase.split(" ").include?("foo") or body.downcase.split(" ").include?("bar"))
		errors.add(:body, "cant have the words foo or bar")
  	end

  end

  def user_liked(user)
    likes.each  do |like|
      if like.user.email == user.email
        return true
      end
    end
    false
  end

end
