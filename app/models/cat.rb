class Cat < ActiveRecord::Base
  validates :birth_date, :color, :sex, :name, presence: true
  validate :valid_sex?
  validates :owner, presence: true

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    primary_key: :id,
    foreign_key: :cat_id
  )

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def age
    time_now = Time.now.to_date

    age = (time_now - birth_date).to_i / 365
  end

  private

  def valid_sex?
    if sex.length > 1
      errors[:valid_sex] << "Sex has to be 1 character long"
    elsif !["M", "F"].include?(sex)
      errors[:valid_sex] << "Sex must be M or F"
    end
  end
end
