class FusionLink < Formula
  desc "Local-first connection daemon: outbound WSS to the fusion-mlx.cn cloud broker"
  homepage "https://github.com/dahai80/fusion-link"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.3/fusion-link-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "29ceba15226a6e2532fdce8b3d30605af0fa8b29d4ffcbb95f1ba02cb59eb2d2"
    else
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.3/fusion-link-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "27235f31c24875b3e0f4f27eaa183ea1bdb5d1154358e1744f08c4d39b82dd17"
    end
  end

  on_linux do
    url "https://github.com/dahai80/fusion-link/releases/download/v0.1.3/fusion-link-v0.1.3-x86_64-unknown-linux-musl.tar.gz"
    sha256 "adebf8315a5bac8f1d3c3d931ac76a4927c2e8209028e8891223ed55818069b0"
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
