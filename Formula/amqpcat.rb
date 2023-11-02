class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/v0.2.4.tar.gz"
  sha256 "4dccbd37e4cee1bc0119748921c9bbce86137bc6ba870b1861823ce76a09e3eb"
  head "https://github.com/cloudamqp/amqpcat.git"

  depends_on "crystal" => :build

  def install
    system "shards", "build", "--release", "--production", "--no-debug"
    bin.install "bin/amqpcat"
  end

  test do
    system "#{bin}/amqpcat", "--version"
  end
end
