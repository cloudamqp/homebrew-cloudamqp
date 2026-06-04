class CloudamqpCli < Formula
  desc "CLI tool for managing CloudAMQP instances"
  homepage "https://github.com/cloudamqp/cli"
  url "https://github.com/cloudamqp/cli/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "c10a907c47d5d07d8c7c27c6aef1ecdd41f487e76a25ee87ab329893fc2a6fcf"
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
