class Compactp < Formula
  desc "A production-grade parser frontend for the Compact language (Midnight Network)"
  homepage "https://github.com/devrelaicom/compactp"
  version "0.1.0-beta.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/devrelaicom/compactp/releases/download/compactp-v0.1.0-beta.1/compactp-aarch64-apple-darwin.tar.xz"
      sha256 "f78722c71c7d449843efc66bb2983d3fc8a5f9b94c72aacaf599cf8f2417db31"
    end
    if Hardware::CPU.intel?
      url "https://github.com/devrelaicom/compactp/releases/download/compactp-v0.1.0-beta.1/compactp-x86_64-apple-darwin.tar.xz"
      sha256 "8449ab4e5724b49e533be8ae119ed273d733232f52bb1fee796290d84dab2c81"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/devrelaicom/compactp/releases/download/compactp-v0.1.0-beta.1/compactp-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "30b0988a3c303ba836798cc511f253d3cee2674e33d726b49b68fb79233444b7"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "compactp" if OS.mac? && Hardware::CPU.arm?
    bin.install "compactp" if OS.mac? && Hardware::CPU.intel?
    bin.install "compactp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
