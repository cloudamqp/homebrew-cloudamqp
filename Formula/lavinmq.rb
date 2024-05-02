class Lavinmq < Formula
  desc "Fast and efficient AMQP 0-9-1 server"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v1.2.10.tar.gz"
  sha256 "64106827735a083f02bc2b96aaf3546d04e4dedbf0e2b99840b0926aa65fe9c3"
  head "https://github.com/cloudamqp/lavinmq.git"

  depends_on "crystal" => :build
  depends_on "openssl" => :build

  def install
    system "make", "all", "DOCS="
    bin.install "bin/lavinmq"
    bin.install "bin/lavinmqctl"
    bin.install "bin/lavinmqperf"
  end

  test do
    system "#{bin}/lavinmq", "--version"
    system "#{bin}/lavinmqctl", "--version"
    system "#{bin}/lavinmqperf", "--version"
  end
end
