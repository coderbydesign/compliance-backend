# frozen_string_literal: true

# Abstract record class to be applied to all models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Sortable

  AN = Arel::Nodes

  scope :older_than, lambda { |datetime|
    where(arel_table[:created_at].lt(datetime))
  }

  def ==(other)
    return super if self.class.column_names.include? 'id'

    self.class.column_names.map do |col|
      send(col) == other.send(col)
    end.all?
  end

  def self.taggable?
    false
  end

  def self.count_by
    primary_key.to_sym
  end

  # Returns with a list of symbols describing one-to-one relationships
  def self.one_to_one
    reflections.each_with_object([]) do |(key, reflection), obj|
      obj << key.to_sym if reflection.has_one? || reflection.belongs_to?
    end
  end
end
