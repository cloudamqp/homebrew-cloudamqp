class Lavinmq < Formula
  desc "Fast and efficient AMQP 0-9-1 server"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v1.2.11.tar.gz"
  sha256 "b15a77514f059c6f6d5da94770fcdf2bfd317d1dc072f53ba8cc3a9fdfb335c0"
  head "https://github.com/cloudamqp/lavinmq.git"

  depends_on "crystal" => :build
  depends_on "openssl" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "lz4"
  depends_on "pcre2"

  def install
    system "make", "all", "DOCS="
    bin.install "bin/lavinmq"
    bin.install "bin/lavinmqctl"
    bin.install "bin/lavinmqperf"
  end

  service do
    run [opt_bin/"lavinmq", "-D", "/opt/homebrew/var/lavinmq"]
  end

  test do
    system "#{bin}/lavinmq", "--version"
    system "#{bin}/lavinmqctl", "--version"
    system "#{bin}/lavinmqperf", "--version"
  end
end
