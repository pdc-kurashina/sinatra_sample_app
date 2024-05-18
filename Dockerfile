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
