class Sparoid < Formula
  desc "SPA client"
  homepage "https://github.com/84codes/sparoid"
  url "https://github.com/84codes/sparoid/archive/v1.1.12.tar.gz"
  sha256 "5f6b6daf553adff3b2aa6dcfad99896e3069f16133cab1bdadda7ccd1ca6e43e"
  head "https://github.com/84codes/sparoid.git"

  depends_on "crystal" => :build
  depends_on "openssl" => :build

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
