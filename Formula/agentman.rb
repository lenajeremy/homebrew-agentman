# Homebrew formula for agentman.
#
# Ships the prebuilt `am` binary from the GitHub release rather than building
# from source, so installing does not require a Go toolchain.
class Agentman < Formula
  desc "Watch your coding agents from your phone and answer them when they get stuck"
  homepage "https://github.com/lenajeremy/agentman"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lenajeremy/agentman/releases/download/v0.1.0/agentman_v0.1.0_darwin_arm64.tar.gz"
      sha256 "99b920b3ac2117185a530e3171be543616a3fa221b9adf11ec14c66a02b4190d"
    end
    on_intel do
      url "https://github.com/lenajeremy/agentman/releases/download/v0.1.0/agentman_v0.1.0_darwin_amd64.tar.gz"
      sha256 "3890bcb0a12936f34dcf78e111f7e57d8acc0aad31557fb0cd4529352490917f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lenajeremy/agentman/releases/download/v0.1.0/agentman_v0.1.0_linux_arm64.tar.gz"
      sha256 "6b54afbd2b7aeeaef923fce62d649bb3f06ee5f4f48668d6bd0b12ac7dc23d2f"
    end
    on_intel do
      url "https://github.com/lenajeremy/agentman/releases/download/v0.1.0/agentman_v0.1.0_linux_amd64.tar.gz"
      sha256 "4fc77c7ff84e072d11730a5b2cac4a5ed15405b698d3f7fadc3ba24f3f2aed87"
    end
  end

  # Only needed to send messages to Claude Code or Codex, and to answer their
  # prompts. Everything else works without it, so this is a recommendation
  # rather than a hard dependency.
  depends_on "tmux" => :recommended

  def install
    bin.install "am"
  end

  def caveats
    <<~EOS
      Get started:

        am install-hooks
        am serve --relay https://agentman-production.up.railway.app
        am pair

      Then launch agents through the wrapper so you can message them back:

        am claude
        am codex

      The public relay stores nothing. To run your own, see:
        https://github.com/lenajeremy/agentman#self-hosting-the-relay
    EOS
  end

  test do
    assert_match "agentman", shell_output("#{bin}/am --help")
  end
end
