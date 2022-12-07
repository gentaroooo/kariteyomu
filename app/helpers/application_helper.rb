module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
    'Kariteyomu（管理画面）'
   else
    'Kariteyomu'
   end
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def active_if(path)
    path == controller_path ? 'active' : ''
  end

  def default_meta_tags
    {
      site: 'Kariteyomu',
      charset: 'utf-8',
      reverse: true,
      title: '絵本検索と図書館検索を掛け合わせたサービスです',
      description: '絵本検索と図書館検索を掛け合わせたサービスです。',
      keywords: 'Kariteyomu,かりてよむ,借りてよむ,図書館,絵本,子育て',
      separator: '|',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.png') },
        { href: image_url('favicon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: 'Kariteyomu',
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('t_ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@zaki_run321',
        image: image_url('t_ogp.png'),
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
