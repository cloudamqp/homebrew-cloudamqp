class Sparoid < Formula
  desc "SPA client"
  homepage "https://github.com/84codes/sparoid"
  url "https://github.com/84codes/sparoid/archive/v1.0.1.tar.gz"
  sha256 "d936308f1a06638f7713694aac96dee8d403ceeecd03981f403cfd40933c3f5d"
  head "https://github.com/84codes/sparoid.git"

  depends_on "crystal" => :build

  def install
    system "shards", "build",
                     "--release",
                     "--production"
    bin.install "bin/sparoid"
    bin.install "bin/sparoid-server"
  end

  test do
    system "#{bin}/sparoid", "--version"
    system "#{bin}/sparoid-server", "--version"
  end
end
