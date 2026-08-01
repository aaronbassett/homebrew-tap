class Rover < Formula
  desc "An MCP server for fetching and prepping web content for LLM agents."
  homepage "https://github.com/aaronbassett/rover"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.5.0/rover-fetch-aarch64-apple-darwin.tar.xz"
      sha256 "a0d4dd77e02b87d491d637058020fb5913c2fd76176eef3c03a0dbb2152ddb2a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.5.0/rover-fetch-x86_64-apple-darwin.tar.xz"
      sha256 "fe6cc4d35fce84c7c62fe484e472d41681f2097a2f0c9b1e6d3d4f14deb31ee0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.5.0/rover-fetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6eb070c41b0e284337ea484cb69b97400b657f89b9c05ce60be318155a413fa1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.5.0/rover-fetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bee0b9864a41ff3d3204409e9238310862ca505994ebb275fe141065a3b89c5f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
