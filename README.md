# README

## 超絶簡単なRuby実行環境構築

### 1. 任意のディレクトリに移動する

```sh
mkdir ruby_code
cd ruby_code
```

### 2. ターミナルでファイル/ディレクトリを作成する

```sh
touch Dockerfile
touch docker-compose.yml
touch Gemfile
touch your_script.rb
touch config.ru
mkdir views
```

### 3. `Dockerfile`に以下のコードを記述する

```Dockerfile
# ベースイメージとして公式のRubyイメージを使用
FROM ruby:latest

# 作業ディレクトリを設定
WORKDIR /usr/src/app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# 依存関係をインストール
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . .

# デフォルトのコマンドを設定
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "4567"]
```

### 4. `docker-compose.yml`に以下のコードを記述する

```yml
version: '3.8'

services:
  app:
    build:
      context: .
    volumes:
      - .:/usr/src/app
    ports:
      - "4567:4567"
    environment:
      - RACK_ENV=development
```

### 5. `Gemfile`に以下のコードを記述する

```Gemfile
source "https://rubygems.org"

gem "sinatra"
gem "rackup"
```

### 6. Gemfile.lockを生成する

```sh
bundle install
```

### 7. `your_script.rb`に以下のコードを記述する

```ruby
require 'sinatra'

$data = {}

get '/' do
  'Hello, World!'
end

get '/hello/:name' do
  "Hello, #{params[:name]}!"
end

get '/index' do
  erb :index
end

get '/form' do
  erb :form
end

post '/submit' do
  $data[:name] = params[:name]
  $data[:age] = params[:age]
  redirect '/show'
end

get '/show' do
  erb :show, locals: { name: $data[:name], age: $data[:age] }
end
```

### 8. `views`ディレクトリにindex/form/showのファイルを作成する

詳しくはソースコード参照

### 9. `config.ru`に以下のコードを記述する

```ruby
# config.ru
require 'sinatra'
require './your_script'

set :port, 4567

run Sinatra::Application
```

### 10. Dockerイメージをビルドする

```sh
docker-compose build
```

### 11. コンテナを実行してSinatraアプリケーションを起動する

```sh
docker-compose up
```

### 12. 使用しない時はコンテナを閉じる

```sh
docker-compose down
```
