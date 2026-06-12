class LavinmqPrerelease < Formula
  desc "Message broker implementing the AMQP 0-9-1 and MQTT protocols (pre-release)"
  homepage "https://lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v2.9.0-rc.1.tar.gz"
  sha256 "da340e0efe1b45eea1ac6fbded6834bc4b0a5a25fd2b348625b2280a1895eab7"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+-(?:rc|beta|alpha)(?:\.\d+)?)$/i)
  end

  depends_on "crystal" => :build
  depends_on "help2man" => :build
  depends_on "bdw-gc"
  depends_on "lz4"
  depends_on "openssl@3"
  depends_on "pcre2"

  on_macos do
    # GNU install (Makefile uses `install -D -t`); Linux's /usr/bin/install is already GNU.
    depends_on "coreutils" => :build
  end

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "zlib-ng-compat"
  end

  conflicts_with "lavinmq", because: "both install `lavinmq` binaries"

  def install
    ENV.prepend_path "PATH", Formula["coreutils"].opt_libexec/"gnubin" if OS.mac?

    inreplace "extras/lavinmq.ini", /^data_dir.*/, "data_dir = #{var}/lavinmq"

    system "make", "install",
           "DOCS=",
           "PREFIX=#{prefix}",
           "SYSCONFDIR=#{buildpath}/stage/etc",
           "UNITDIR=#{buildpath}/stage/systemd",
           "SYSUSERSDIR=#{buildpath}/stage/sysusers",
           "SHAREDSTATEDIR=#{buildpath}/stage/var"

    pkgetc.install "extras/lavinmq.ini"
  end

  service do
    run [opt_bin/"lavinmq", "-c", etc/"lavinmq/lavinmq.ini"]
    keep_alive true
  end

  test do
    pid = spawn bin/"lavinmq", "--data-dir", testpath/"data"
    30.times do
      break if File.exist?("/tmp/lavinmqctl.sock")

      sleep 1
    end
    output = shell_output("#{bin}/lavinmqctl status")
    assert_match "Uptime", output
  ensure
    Process.kill("TERM", pid)
    Process.wait(pid)
  end
end
