# frozen_string_literal: true

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop_fix) do |t|
  t.options = ['-a']
end
