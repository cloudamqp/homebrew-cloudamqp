class Sparoid < Formula
  desc "SPA client"
  homepage "https://github.com/84codes/sparoid"
  url "https://github.com/84codes/sparoid/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "56a0be2cb54297f97ffb5b9e70064b2dad62c6c7938c825fac378a94cd3296de"
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
