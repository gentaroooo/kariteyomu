module ApplicationHelper
  module ApplicationHelpe
    def google_book_thumbnail(google_book)
      google_book['volumeInfo']['imageLinks'].nil? ? 'sample.jpg' : google_book['volumeInfo']['imageLinks']['thumbnail']
    end
  
    def set_google_book_params(google_book)
      google_book['volumeInfo']['bookImage'] = google_book.dig('volumeInfo', 'imageLinks', 'thumbnail')
      google_book['volumeInfo'].slice('title', 'authors', 'publishedDate', 'infoLink', 'bookImage')
    end
  end
end
