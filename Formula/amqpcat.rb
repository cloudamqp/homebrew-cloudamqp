class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/refs/tags/v0.2.5.tar.gz"
  sha256 "05917d52a06bdd7a45e85f620117a93f9caa0747f2468a65862d53b8b7ca6999"
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
