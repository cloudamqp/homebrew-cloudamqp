class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  head "https://github.com/cloudamqp/amqpcat.git"
  url "https://github.com/cloudamqp/amqpcat/archive/v0.2.0.tar.gz"
  sha256 "2e740017e63bf34f4d966b27fe4e52caabe660f1169b100496c225cd19b21c65"

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
