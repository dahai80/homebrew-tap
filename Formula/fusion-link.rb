class FusionLink < Formula
  desc "Local-first connection daemon: outbound WSS to the fusion-mlx.cn cloud broker"
  homepage "https://github.com/dahai80/fusion-link"
  version "0.1.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.5/fusion-link-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "731860f4be294329d875816b9a9db7cd502242fc7fc775d2a4918ea07289eb38"
    else
      url "https://github.com/dahai80/fusion-link/releases/download/v0.1.5/fusion-link-v0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "6ef6043c2058f3e90293aa0ca9cba01b5083cdbf4823412f30fb73e51322bcaa"
    end
  end

  on_linux do
    url "https://github.com/dahai80/fusion-link/releases/download/v0.1.5/fusion-link-v0.1.5-x86_64-unknown-linux-musl.tar.gz"
    sha256 "57356238784d4bab7f9267aaa7c2fbc549727be64f72631e19014e8cea7994b3"
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
