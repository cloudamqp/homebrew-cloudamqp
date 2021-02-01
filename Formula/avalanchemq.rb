class Avalanchemq < Formula
  desc "AMQP 0-9-1 server"
  homepage "https://github.com/cloudamqp/avalanchemq"
  url "https://github.com/cloudamqp/avalanchemq/archive/v1.0.0-alpha.25.tar.gz"
  sha256 "ab23acd6362d62d082f55e7b6347598fc2792166f516eb7c00fad5876a4b6ba3"
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
