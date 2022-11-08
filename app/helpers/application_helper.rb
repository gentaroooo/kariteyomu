module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'Kariteyomu'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      site: 'Kariteyomu',
      charset: 'utf-8',
      description: '絵本検索と図書館検索を掛け合わせたサービスです。近所の図書館でお気に入りの絵本を探そう',
      keywords: 'Kariteyomu,かりてよむ,借りてよむ,図書館,絵本,子育て',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.png') },
        { href: image_url('favicon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('top_image.jpg'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
      }
    }
  end

  def google_book_thumbnail(google_book)
    google_book['volumeInfo']['imageLinks'].nil? ? 'sample.jpg' : google_book['volumeInfo']['imageLinks']['thumbnail']
  end

  def set_google_book_params(google_book)
    google_book['volumeInfo']['bookImage'] = google_book.dig('volumeInfo', 'imageLinks', 'thumbnail')
    if google_book['volumeInfo']['bookImage'].present?
      google_book['volumeInfo']['bookImage'] = google_book['volumeInfo']['bookImage'].gsub("http", "https")
    end

    if google_book['volumeInfo']['industryIdentifiers']&.select { |h| h["type"].include?("ISBN") }.present?
      google_book['volumeInfo']['systemid'] = google_book['volumeInfo']['industryIdentifiers'].select { |h| h["type"].include?("ISBN") }.first["identifier"]
    end

    google_book['volumeInfo'].slice('title', 'authors', 'publishedDate', 'infoLink', 'bookImage', 'systemid', 'canonicalVolumeLink')
  end
end
