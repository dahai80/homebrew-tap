class FusionLink < Formula
  desc "Local-first connection daemon: outbound WSS to the fusion-mlx.cn cloud broker"
  homepage "https://github.com/dahai80/fusion-link"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.1/fusion-link-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "5fd0e4e49f95ea4b72187305eb8e661f766f507dbd25ecce36bef8f9ef304a91"
    else
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.1/fusion-link-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "93bc15d841741d3ed08a45f4e0ccadf7b37e0b26dd7cc934b564ed9b7d7347ca"
    end
  end

  on_linux do
    url "https://github.com/dahai80/fusion-link/releases/download/v0.1.1/fusion-link-v0.1.1-x86_64-unknown-linux-musl.tar.gz"
    sha256 "29cb2e8ed024156d7d0f13a9c78c23b8fe28e7201537552b4e7c131ab7a289e1"
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
