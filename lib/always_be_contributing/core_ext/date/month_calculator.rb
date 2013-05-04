class Date
  def beginning_of_month
    change(day: 1)
  end
  def change(options)
    ::Date.new(
      options.fetch(:year, year),
      options.fetch(:month, month),
      options.fetch(:day, day)
    )
  end
end
