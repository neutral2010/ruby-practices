#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  file_names = ARGV

  if ARGV.length.zero?
    options['l'] ? output_by_standard_input_with_option : output_by_standard_input
  elsif ARGV.length == 1
    options['l'] ? output_with_option(file_names) : output_without_option(file_names)
  elsif ARGV.length >= 2
    if !options['l']
      output_without_option(file_names)
      sum_up_count(file_names)
    else
      output_with_option(file_names)
      sum_up_count_with_option(file_names)
    end
  end
end

def output_with_option(file_names)
  file_names.each do |file_name|
    count_lines = IO.readlines(file_name).length
    file_basename = File.basename(file_name)
    format = '%7s %-10s'
    printf format, count_lines, file_basename
    puts "\n"
  end
end

def sum_up_count_with_option(file_names)
  total_count_lines = sum_up_count_lines(file_names)
  format = '%7s %-10s'
  printf format, total_count_lines, 'total'
end

def output_by_standard_input_with_option
  text = read_text
  count_lines = text.split("\n").length
  format = '%7s'
  printf format, count_lines
end

def read_text
  $stdin.read
end

def output_by_standard_input
  text = read_text
  count_lines = text.split("\n").length
  count_words = text.split(/\s+/).size
  count_bites = text.to_s.bytesize
  format = '%7s %7s %7s'
  printf format, count_lines, count_words, count_bites
end

def output_without_option(file_names)
  file_names.each do |file_name|
    text = read_from_text(file_name)
    count_lines = IO.readlines(file_name).length
    count_words = text.split(/\s+/).size
    count_bites = text.bytesize
    file_basename = File.basename(file_name)

    format = '%7s %7s %7s %-10s'
    printf format, count_lines, count_words, count_bites, file_basename
    puts "\n"
  end
end

def read_from_text(file_name)
  File.read(file_name)
end

def sum_up_count(file_names)
  total_count_lines = sum_up_count_lines(file_names)
  total_count_words = sum_up_count_words(file_names)
  total_count_bites = sum_up_count_bites(file_names)
  format = '%7s %7s %7s %-10s'
  printf format, total_count_lines, total_count_words, total_count_bites, 'total'
end

def sum_up_count_lines(file_names)
  file_names.map { |file_name| IO.readlines(file_name).size }.sum
end

def sum_up_count_words(file_names)
  file_names.map { |file_name| File.read(file_name).split(/\s+/).size }.sum
end

def sum_up_count_bites(file_names)
  file_names.map { |file_name| File::Stat.new(file_name).size }.sum
end

main