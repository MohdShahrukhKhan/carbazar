class Chat < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :dealer, class_name: 'User', foreign_key: 'dealer_id'
  has_many :messages, dependent: :destroy

  validates :customer_id, presence: true
  validates :dealer_id, presence: true
end
