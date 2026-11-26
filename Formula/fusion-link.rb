class FusionLink < Formula
  desc "Local-first connection daemon: outbound WSS to the fusion-mlx.cn cloud broker"
  homepage "https://github.com/dahai80/fusion-link"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.4/fusion-link-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "248f6db7fdc4f62c08c0b0c8d7b36e1c3d367cebb1014ce5f6213984c1bb3165"
    else
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.4/fusion-link-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "ca2133f9ec01bf78cd15d714d6c34c2706c7987897defff7eab48fe4ca5031f1"
    end
  end

  on_linux do
    url "https://github.com/dahai80/fusion-link/releases/download/v0.1.4/fusion-link-v0.1.4-x86_64-unknown-linux-musl.tar.gz"
    sha256 "879ed1863a9776f42b189a14c4c95592a6546d38a9386f5c1fe05b6aceb5458b"
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
