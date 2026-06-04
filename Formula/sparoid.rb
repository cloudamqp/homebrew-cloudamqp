class Sparoid < Formula
  desc "SPA client"
  homepage "https://github.com/84codes/sparoid"
  url "https://github.com/84codes/sparoid/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "efdbee1cf730a58f747e624462b15738b73b030d52234d98f92b546acd3c522c"
  head "https://github.com/84codes/sparoid.git", branch: "main"

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "openssl@3"
  depends_on "pcre2"

  on_linux do
    depends_on "nftables"
    depends_on "zlib-ng-compat"
  end

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
