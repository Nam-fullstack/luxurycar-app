class Variant < ApplicationRecord
  belongs_to :model
  has_one :make, through: :model
  has_many :listings
  has_one :door
  has_one :body_type, through: :door
  has_one :drive
  has_one :engine
  has_one :fuel
  has_one :year
  has_one :speed
  has_one :transmission, through: :speed

  # These should be optional, so might comment out validations here
  # and validate in form.
  # validates :fuel_consumption, numericality: { greater_than: 0 }
  # validates :weight, numericality: { greater_than: 0 }
  # validates :safety_rating, numericality: { great_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  after_save :update_name

  private

  def update_name
    # @variant.name = "#{@variant.engine_id.name}"
    puts "####################################### This is the variant #{@variant}"
  end

end
