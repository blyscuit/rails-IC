# frozen_string_literal: true

require 'csv'

class CSVUploadForm
  include ActiveModel::Validations

  attr_reader :file

  validates_with CSVValidator

  def initialize(user)
    @user = user
  end

  def save(file)
    @file = file
    return false unless file && valid?

    begin
      save_keywords
    rescue ActiveRecord::StatementInvalid
      errors.add(:base, I18n.t('csv.validation.bad_keyword_length'))
    end
    errors.empty?
  end

  private

  def save_keywords
    keyword_hash.each do |hash|
      keyword = Keyword.find_or_create_by!(hash)
      keyword_user_hash = { keyword: keyword, user: @user }
      KeywordUser.find_or_create_by!(keyword_user_hash)
    end
  end

  def keyword_hash
    CSV.read(file).filter_map do |row|
      name = row.join(',')
      return nil if name.blank?

      { name: name }
    end
  end
end
