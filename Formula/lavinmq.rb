class Lavinmq < Formula
  desc "Fast and efficient AMQP 0-9-1 server"
  homepage "https://www.lavinmq.com"
  url "https://github.com/cloudamqp/lavinmq/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "b872b04d964939930ce87277e6ef451a7a91f8afbeefc65a9e0cf6cd42903553"
  head "https://github.com/cloudamqp/lavinmq.git"

  depends_on "crystal" => :build
  depends_on "help2man" => :build
  depends_on "openssl" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "lz4"
  depends_on "pcre2"

  def install
    system "make", "bin/lavinmq", "bin/lavinmqperf", "DOCS="
    system "crystal", "build", "src/lavinmqctl.cr", "-o", "bin/lavinmqctl", "--release", "--error-on-warnings",
      "--link-flags=-pie"
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

  service do
    run [opt_bin/"lavinmq", "-c", etc/"lavinmq/lavinmq.ini"]
  end

  test do
    system "#{bin}/lavinmq", "--version"
    system "#{bin}/lavinmqctl", "--version"
    system "#{bin}/lavinmqperf", "--version"
  end
end
