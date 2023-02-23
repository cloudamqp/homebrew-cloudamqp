class Sparoid < Formula
  desc "SPA client"
  homepage "https://github.com/84codes/sparoid"
  url "https://github.com/84codes/sparoid/archive/v1.1.11.tar.gz"
  sha256 "29606ef48e5600a521b4cb733489725383959acb78959290387682f936f5d833"
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
