class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "d08973a92748601188c90caa4ec31b8f8f8efa2a6c202661bff8c6a527b3a861"
  head "https://github.com/cloudamqp/amqpcat.git", branch: "main"

  depends_on "crystal" => :build
  depends_on "openssl@3"

  def install
    system "shards", "build", "--release", "--production", "--no-debug"
    bin.install "bin/amqpcat"
  end

  test do
    system "#{bin}/amqpcat", "--version"
  end
end
