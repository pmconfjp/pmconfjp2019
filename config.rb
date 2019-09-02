# Time.zone = 'Tokyo' # rubocop:disable all

activate :directory_indexes

activate :blog do |blog|
  blog.name = 'articles'
  blog.prefix = 'articles'

  blog.layout = 'article_layout'
  blog.permalink = '/{year}/{month}/{day}/{title}.html'
  blog.sources = '/items/{year}-{month}-{day}-{title}.html'
  blog.new_article_template = 'article_template.erb'
  blog.default_extension = '.md'

  blog.custom_collections = {
    category: {
      link: '/categories/{category}.html',
      template: '/articles/category.html'
    }
  }
end

activate :blog do |blog|
  blog.name = 'sessions'
  blog.prefix = 'sessions'

  blog.layout = 'sessions_layout'
  blog.permalink = '/{year}/{month}/{day}/{title}.html'
  blog.sources = '/items/{year}-{month}-{day}-{title}.html'
  blog.new_article_template = 'sessions_template.erb'
  blog.default_extension = '.md'
end

activate :blog do |blog|
  blog.name = 'tips'
  blog.prefix = 'tips'

  blog.layout = 'tips_layout'
  blog.permalink = '/{title}.html'
  blog.sources = '/items/{title}.html'
  blog.new_article_template = 'tips_template.erb'
  blog.default_extension = '.md'
end

page 'sitemap.xml', layout: 'xml_layout'

helpers do
  def page_title
    if current_page.data.title
      "#{current_page.data.title} | プロダクトマネージャー・カンファレンス 2019"
    elsif yield_content(:title)
      "#{yield_content(:title)} | プロダクトマネージャー・カンファレンス 2019"
    else
      'プロダクトマネージャー・カンファレンス 2019'
    end
  end

  def page_description
    if current_page.data.description
      current_page.data.description
    elsif yield_content(:description)
      yield_content(:description)
    else
      'プロダクトマネージャー・カンファレンス 2019 - 全ての企業にプロダクトマネジメントを'
    end
  end

  def page_url
    "https://2019.pmconf.jp#{current_page.url}"
  end

  def jobs
    arr = []
    data.jobs.each { |j| arr << j }
    arr
  end

  def members
    arr = []
    data.staff.organizers.each { |o| arr << o }
    data.staff.secretariat.each { |o| arr << o }
    arr
  end

  def keynotes
    arr = []
    data.keynote.keynotes.each { |keynote| arr << keynote }
    arr
  end

# rubocop:disable all
  def speakers
    arr = []
    data.speakers.normals.each { |spn| arr << spn }
    arr
  end

  def sponsors
    arr = []
    data.sponsors.platinas.each { |sp| arr << sp }
    data.sponsors.golds.each { |sg| arr << sg }
    data.sponsors.sivers.each { |ss| arr << ss }
    data.sponsors.bronze.each { |sb| arr << sb }
    data.sponsors.logo.each { |sl| arr << sl }
    data.sponsors.drinks.each { |sd| arr << sd }
    data.sponsors.communities.each { |sc| arr << sc }
    data.sponsors.personals.each { |ps| arr << ps }
    arr
  end
end
# rubocop:enable all

set :images_dir, 'assets/images'

configure :development do
  activate :livereload
end

configure :build do
  activate :relative_assets
end

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.branch = 'master'
  deploy.remote = "https://#{ENV['GH_TOKEN']}@github.com/pmconfjp/pmconfjp2019.git" # rubocop:disable all
  deploy.build_before = true
  deploy.commit_message = '[ci skip]'
end

activate :external_pipeline,
         name: :webpack,
         command: build? ? './node_modules/webpack/bin/webpack.js -p --bail' : './node_modules/webpack/bin/webpack.js --watch -d', # rubocop:disable all
         source: '.tmp/dist',
         latency: 1
