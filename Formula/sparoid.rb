class Sparoid < Formula
  desc "SPA client"
  homepage "https://github.com/84codes/sparoid"
  url "https://github.com/84codes/sparoid/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "fe17fdddbba380ebbbb119473aade7f216c7a0a61c848881435ac5a9d546061a"
  head "https://github.com/84codes/sparoid.git"

  depends_on "crystal" => :build
  depends_on "openssl@3"

  def install
    components = ["sparoid"]
    components << "sparoid-server" if OS.linux?

    system "shards", "build",
                     "--release",
                     "--production",
                     *components
    bin.install "bin/sparoid"
    bin.install "bin/sparoid-server" if OS.linux?
  end

  test do
    system "#{bin}/sparoid", "--version"
    system "#{bin}/sparoid-server", "--version" if OS.linux?
  end
end
