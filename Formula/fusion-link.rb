class FusionLink < Formula
  desc "Local-first connection daemon: outbound WSS to the fusion-mlx.cn cloud broker"
  homepage "https://github.com/dahai80/fusion-link"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.2/fusion-link-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "728ccf0f9b07415ea16ee4586ac1ae4d79170c878acce60a9cb4fcf5a796879b"
    else
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.2/fusion-link-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "d6c2bf273a0be3a93611c7242d310219c266bdf5aa0e6a63e730834edc199b06"
    end
  end

  on_linux do
    url "https://github.com/dahai80/fusion-link/releases/download/v0.1.2/fusion-link-v0.1.2-x86_64-unknown-linux-musl.tar.gz"
    sha256 "5ad570a1280baa71f114eef67f46666872c899b76e4202acc170f33f46dd7de0"
  end

  def install
    bin.install "fusion-link"
  end

  def caveats
    <<~EOS
      Bind your device before running the daemon:
        fusion-link bind <one-time-code>
      Start/stop the daemon:
        #{opt_bin}/fusion-link run   # foreground; see project start.sh for pidfile management
    EOS
  end

  test do
    assert_match "fusion-link", shell_output("#{bin}/fusion-link --version")
    assert_match "bound:", shell_output("#{bin}/fusion-link status")
  end
end
