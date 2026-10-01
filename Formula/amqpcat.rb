class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "e274e074c42ebe89b72a2cf5ff2d1b1906679fa3b949002d8b6c5c674c210b37"
  head "https://github.com/cloudamqp/amqpcat.git", branch: "main"

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "openssl@4"
  depends_on "pcre2"

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "zlib-ng-compat"
  end

  def install
    system "shards", "build", "--release", "--production", "--no-debug"
    bin.install "bin/amqpcat"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/amqpcat --version").strip
  end
end
