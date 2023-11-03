class Lavinmq < Formula
  desc "Fast and efficient AMQP 0-9-1 server"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v1.2.4.tar.gz"
  sha256 "506baacac7c0fa34add959b517da19dec1db5537434f660c5cded51dff227e4f"
  head "https://github.com/cloudamqp/lavinmq.git"

  depends_on "node"
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
