class Post < ApplicationRecord

  validates :title, :email, presence: true
  validate :must_be_age
  before_validation :ensure_tile_has_a_value
  # after_validation :ensure_tile_has_a_value
  after_commit :method_to_call_after_commit, on: :destroy
  around_create :my_callback_method

  def must_be_age
    if ! (age?)
      errors.add(:age,"Custom Error" ,presence: true)
    end
  end

  before_create do
      self.body = title.capitalize if body.blank?
  end

  after_initialize do |post|
    puts "********You have creaded an object!************"
  end

  private

  def ensure_tile_has_a_value
      if title.nil?
        #errors.add(:title,"Custom Error" ,presence: true)
        self.title = email unless email.blank?
      end
  end

  def method_to_call_after_commit
      # Do something knowing that the transaction is committed.
      puts "********You have destroy an object!***********"
  end

  def my_callback_method
      # do some "before_create" stuff here
      puts "********before_create***********"


      yield  # this makes the save happen

      # do some "after_create" stuff here
      puts "********after_create***********"
      puts "******#{body_was}******"
      if body_was == 'Murtaza'

         write_attribute(:body, age_was)
         puts "******now body is = #{body}******"
      end


  end
end
