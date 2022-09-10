class BoardAuthor < ApplicationRecord
  belongs_to :board
  belongs_to :author
end
