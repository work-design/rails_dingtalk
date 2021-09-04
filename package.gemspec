Gem::Specification.new do |s|
  s.name = 'rails_dingtalk'
  s.version = '0.1'
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_dingtalk'
  s.summary = 'Summary of RailsDingtalk'
  s.description = '钉钉'
  s.license = 'MIT'

  s.metadata['homepage_uri'] = s.homepage
  s.metadata['source_code_uri'] = 'https://github.com/work-design/rails_dingtalk'
  s.metadata['changelog_uri'] = 'https://github.com/work-design/rails_dingtalk'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails', '>= 5.0'
end
