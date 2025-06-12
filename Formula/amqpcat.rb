class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e415dc3379971541dca0e48a90d81442674d08076b5aa3dc3ecce1b5b975d550"
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
