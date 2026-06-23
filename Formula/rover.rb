class Rover < Formula
  desc "An MCP server for fetching and prepping web content for LLM agents."
  homepage "https://github.com/aaronbassett/rover"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.1.1/rover-fetch-aarch64-apple-darwin.tar.xz"
      sha256 "e9238656a1ad427acb7ef26882ca6e27b57336dbb76b369d466330317656f77f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.1.1/rover-fetch-x86_64-apple-darwin.tar.xz"
      sha256 "831b2367f995f0cce65870c32d580252f52606cb0d2857f922eb3da2c40f4ce8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.1.1/rover-fetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dcc6bbbb0a4b5869ea4f54deadbdd41a668fc656e8d825b87e9d390e1cc65efe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.1.1/rover-fetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a4c65094c54e13344b1e9588191c56c52bd980d2756057a1f9c64521e98a79f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "chromium"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "rover" if OS.mac? && Hardware::CPU.arm?
    bin.install "rover" if OS.mac? && Hardware::CPU.intel?
    bin.install "rover" if OS.linux? && Hardware::CPU.arm?
    bin.install "rover" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
