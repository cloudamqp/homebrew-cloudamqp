class Lavinmq < Formula
  desc "Fast and efficient AMQP 0-9-1 server"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/v1.0.0-beta.1.tar.gz"
  sha256 "cf28eb19afb30d20f0b3b5541d3a5bd3a59ac832a37b678c4364530bcb9e12ea"
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
