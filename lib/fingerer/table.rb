module Fingerer
  class Table

    @@_width = 74

    def self.row(*cols)
      count = cols.count;

      return "|#{" " * (@@_width + 2)}|" if count == 0

      width = ((@@_width - (count - 1)) / count).to_i
      remainder = (@@_width - ((width * count) + (count - 1))).to_i
      widths = Array.new(count, width)

      # add remainder to last element, if needed
      widths[-1] += remainder if remainder

      widths.map!{|item| "%-#{item}.#{item}s"}

      sprintf("| #{widths.join(" ")} |", *cols)
    end

    def self.header(title = "")
      title = title[0..(@@_width - 5)]
      "+-[ #{title} ]#{"-" * (@@_width - (title.length + 3))}+"
    end

    def self.line
      "+#{"-" * (@@_width + 2)}+"
    end
  end
end
