class Beverage < MenuItem
  validates :alcoholic, inclusion: { in: [true, false] }
end
