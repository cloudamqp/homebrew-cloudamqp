class Lavinmq < Formula
  desc "Fast and efficient AMQP 0-9-1 server"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "5c8eaeb9298a4f1bb9e4a3bcc14a98931713c4eb8564159a220ca82bc64c6e4d"
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
    run [opt_bin / "lavinmq", "-D", var / "lavinmq"]
  end

  test do
    system "#{bin}/lavinmq", "--version"
    system "#{bin}/lavinmqctl", "--version"
    system "#{bin}/lavinmqperf", "--version"
  end
end
