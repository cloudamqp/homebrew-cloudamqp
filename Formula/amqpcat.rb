class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/v0.2.1.tar.gz"
  sha256 "910502076018521c0df788a8100e72fa0852d8352e64ccbc09d647c5ab6911d3"
  head "https://github.com/cloudamqp/amqpcat.git"

  depends_on "crystal" => :build

  def install
    system "shards", "build",
                     "--release",
                     "--production",
                     "--no-debug"
    bin.install "bin/amqpcat"
  end

  test do
    system "#{bin}/amqpcat", "--version"
  end
end
