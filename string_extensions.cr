module StringExtensions
  BLANK_REGEX = /\A[[:space:]]*\z/
  def self.whitespace_only?(self)
    BLANK_REGEX === self
  end
  SQUISH_REGEX = /[[:space:]]+/
  def self.squish(self)
    self.gsub(SQUISH_REGEX, ' ').strip
  end
  def self.ordinal(number)
    abs_number = number.abs

    if (11..13).includes?(abs_number % 100)
      "th"
    else
      case abs_number % 10
      when 1
        "st"
      when 2
        "nd"
      when 3
        "rd"
      else
        "th"
      end
    end
  end
end
