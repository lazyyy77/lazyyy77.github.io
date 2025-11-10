FROM ruby:3.2

RUN echo "deb http://mirrors.aliyun.com/debian bookworm main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian bookworm-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends build-essential nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile ./
RUN gem install bundler:2.3.26 && bundle install
COPY . .
CMD ["jekyll", "serve", "-H", "0.0.0.0", "-w", "--config", "_config.yml,_config_docker.yml"]

# # Base image: Ruby with necessary dependencies for Jekyll
# FROM ruby:3.2

# # Install dependencies
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     nodejs \
#     && rm -rf /var/lib/apt/lists/*

# # Set the working directory inside the container
# WORKDIR /usr/src/app

# # Copy Gemfile into the container (necessary for `bundle install`)
# COPY Gemfile ./

# # Install bundler and dependencies
# RUN gem install bundler:2.3.26 && bundle install

# # Command to serve the Jekyll site
# CMD ["jekyll", "serve", "-H", "0.0.0.0", "-w", "--config", "_config.yml,_config_docker.yml"]

