class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "28c7d3ff37a463b5daa476233dcae200d3c855aa9f8e46d7065dd629731f80d7"
  head "https://github.com/cloudamqp/amqpcat.git"

  depends_on "crystal" => :build
  depends_on "openssl" => :build

  def install
    system "shards", "build", "--release", "--production", "--no-debug"
    bin.install "bin/amqpcat"
  end

  test do
    system "#{bin}/amqpcat", "--version"
  end
end
