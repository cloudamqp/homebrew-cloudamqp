class Lavinmq < Formula
  desc "Fast and efficient AMQP 0-9-1 server"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/v1.0.0-beta.8.tar.gz"
  sha256 "e0c7a90bc0b240f2dcf118a9c922c4b0ee604f19dfb2ed0b7137cb73af8abe3b"
  head "https://github.com/cloudamqp/lavinmq.git"

  depends_on "crystal" => :build

  def install
    system "make", "all"
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
