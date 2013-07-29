class DivisionsController < ApplicationController
  def index
    @sort = params[:sort]
    @title = "Divisions &#8212; 2010 (current) &#8212; The Public Whip".html_safe

    order = case @sort
    when nil
      ["division_date DESC", "clock_time DESC", "division_name", "division_number DESC"]
    when "subject"
      ["division_name", "division_date DESC", "clock_time DESC", "division_number DESC"]
    when "rebellions"
      ["rebellions DESC", "division_date DESC", "clock_time DESC", "division_name", "division_number DESC"]
    when "turnout"
      ["turnout DESC", "division_date DESC", "clock_time DESC", "division_name", "division_number DESC"]
    else
      raise "Unexpected value"
    end
    @divisions = Division.joins(:division_info).order(order).all
  end
end
