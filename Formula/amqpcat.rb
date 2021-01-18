class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/v0.2.3.tar.gz"
  sha256 "f2179ee77e12755852ce7e9dd0c609acebd55fb9a5acb718a2e2ede9df68be4e"
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
