class Lavinmq < Formula
  desc "Message Broker built for peaks"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v2.6.2.tar.gz"
  sha256 "e02459d4eb659664bd7df5a58d98bf11bf97776c4c07b830cbee06fe2ec685e0"
  license "Apache-2.0"
  head "https://github.com/cloudamqp/lavinmq.git", branch: "main"

  depends_on "crystal" => :build
  depends_on "help2man" => :build
  depends_on "bdw-gc"
  depends_on "lz4"
  depends_on "openssl"
  depends_on "pcre2"

  def install
    system "make", "bin/lavinmq", "bin/lavinmqctl", "bin/lavinmqperf", "DOCS="
    system "make", "man"

    bin.install "bin/lavinmq"
    bin.install "bin/lavinmqctl"
    bin.install "bin/lavinmqperf"

    man1.install "man1/lavinmq.1"
    man1.install "man1/lavinmqctl.1"
    man1.install "man1/lavinmqperf.1"

    unless lavinmq_config.exist?
      pkgetc.install "extras/lavinmq.ini"
      inreplace lavinmq_config do |s|
        s.gsub!(/^data_dir.*/, "data_dir = #{var}/lavinmq")
      end
    end
  end

  def lavinmq_config
    pkgetc/"lavinmq.ini"
  end

  def post_install
    (var/"lavinmq").mkpath
  end

  service do
    run [opt_bin/"lavinmq", "-c", etc/"lavinmq/lavinmq.ini"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lavinmq --version")
    assert_match version.to_s, shell_output("#{bin}/lavinmqctl --version")
    assert_match "throughput", shell_output("#{bin}/lavinmqperf --help")
  end
end
