class Lavinmq < Formula
  desc "Message broker implementing the AMQP 0-9-1 and MQTT protocols"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v2.6.8.tar.gz"
  sha256 "f94c0a78a687ae6f5a66cdea81ace0e70ebc00981418e353fe14b26555d64a7a"
  license "Apache-2.0"
  head "https://github.com/cloudamqp/lavinmq.git", branch: "main"

  depends_on "crystal" => :build
  depends_on "help2man" => :build
  depends_on "bdw-gc"
  depends_on "lz4"
  depends_on "openssl@3"
  depends_on "pcre2"

  on_linux do
    depends_on "pkgconf" => :build
  end

  def install
    system "make", "bin/lavinmq", "bin/lavinmqctl", "bin/lavinmqperf", "DOCS="
    system "make", "man"

    bin.install "bin/lavinmq"
    bin.install "bin/lavinmqctl"
    bin.install "bin/lavinmqperf"

    man1.install "man1/lavinmq.1"
    man1.install "man1/lavinmqctl.1"
    man1.install "man1/lavinmqperf.1"

    unless (pkgetc/"lavinmq.ini").exist?
      pkgetc.install "extras/lavinmq.ini"
      inreplace pkgetc/"lavinmq.ini", /^data_dir.*/, "data_dir = #{var}/lavinmq"
    end
  end

  def post_install
    (var/"lavinmq").mkpath
  end

  service do
    run [opt_bin/"lavinmq", "-c", etc/"lavinmq/lavinmq.ini"]
    keep_alive true
  end

  test do
    pid = fork do
      exec bin/"lavinmq", "--data-dir", testpath/"data"
    end
    sleep 3
    output = shell_output("#{bin}/lavinmqctl status")
    assert_match "Uptime", output
  ensure
    Process.kill("TERM", pid)
    Process.wait(pid)
  end
end
