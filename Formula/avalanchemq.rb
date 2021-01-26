class Avalanchemq < Formula
  desc "AMQP 0-9-1 server"
  homepage "https://github.com/cloudamqp/avalanchemq"
  url "https://github.com/cloudamqp/avalanchemq/archive/v1.0.0-alpha.23.tar.gz"
  sha256 "a533d09b64c2b1e8e262a034736547371a23a7e439b35b96d9e6d1bb7331991c"
  head "https://github.com/cloudamqp/avalanchemq.git"

  depends_on "crystal" => :build

  def install
    system "shards", "build",
                     "--release",
                     "--production"
    bin.install "bin/avalanchemq"
    bin.install "bin/avalanchemqctl"
    bin.install "bin/avalanchemqperf"
  end

  test do
    system "#{bin}/avalanchemq", "--version"
    system "#{bin}/avalanchemqctl", "--version"
    system "#{bin}/avalanchemqperf", "--version"
  end
end
