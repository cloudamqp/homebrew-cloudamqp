class Cloudamqp < Formula
  desc "CLI tool for managing CloudAMQP instances"
  homepage "https://github.com/cloudamqp/cli"
  url "https://github.com/cloudamqp/cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "1464d530d0ade8d63e77961cd63832d4e7f2cff9d9361a9a7b853bb9189f1b6f"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X cloudamqp-cli/cmd.Version=#{version}
      -X cloudamqp-cli/cmd.BuildDate=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:, output: bin/"cloudamqp")

    generate_completions_from_executable(bin/"cloudamqp", "completion", shells: [:zsh, :fish])
  end

  test do
    system bin/"cloudamqp", "--help"
  end
end
