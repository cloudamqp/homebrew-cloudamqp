class Lavinmq < Formula
  desc "Message broker implementing the AMQP 0-9-1 and MQTT protocols"
  homepage "https://lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v2.7.0.tar.gz"
  sha256 "8aace1e2c93d1d180f85cf1573170d8f057aa85db91106de22286ff4e61524b4"
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
    depends_on "zlib-ng-compat"
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
    Timeout.timeout(30) do
      shell_output("#{bin}/lavinmqctl status")
    rescue RuntimeError
      sleep 1
      retry
    end
    output = shell_output("#{bin}/lavinmqctl status")
    assert_match "Uptime", output
  ensure
    Process.kill("TERM", pid)
    Process.wait(pid)
  end
end
