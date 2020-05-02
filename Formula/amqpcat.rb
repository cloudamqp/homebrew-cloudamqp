# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Amqpcat < Formula
  desc "CLI tool for publishing to and consuming from AMQP servers"
  homepage "https://github.com/cloudamqp/amqpcat"
  url "https://github.com/cloudamqp/amqpcat/archive/v0.2.0.tar.gz"
  sha256 "2e740017e63bf34f4d966b27fe4e52caabe660f1169b100496c225cd19b21c65"

  depends_on "crystal" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "shards", "build",
                     "--release",
                     "--production",
                     "--prefix=#{prefix}"
    system "install", "--strip", "bin/amqpcat", "#{prefix}/bin/"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test amqpcat`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/amqpcat", "--version"
  end
end
