class FusionLink < Formula
  desc "Local-first connection daemon: outbound WSS to the fusion-mlx.cn cloud broker"
  homepage "https://github.com/dahai80/fusion-link"
  version "0.1.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.6/fusion-link-v0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "5de115411aee9ed8927764adb23c08be049cb23efc7e6d04d78f4c4c78e6b857"
    else
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.6/fusion-link-v0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "fe4297530d34968e94cd263534b2ef28bf64db3b1cd9c4c4a2be76dd0f45e455"
    end
  end

  on_linux do
    url "https://github.com/dahai80/fusion-link/releases/download/v0.1.6/fusion-link-v0.1.6-x86_64-unknown-linux-musl.tar.gz"
    sha256 "4a4adf73e69625aed78d6be839618fbf31b7cc50b420aadc994a8d7d0ae3fa31"
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
