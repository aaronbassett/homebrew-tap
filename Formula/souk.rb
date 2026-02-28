class Souk < Formula
  desc "CLI tool for managing Claude Code plugin marketplaces"
  homepage "https://github.com/aaronbassett/souk"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/souk/releases/download/souk-v0.1.1/souk-aarch64-apple-darwin.tar.xz"
      sha256 "2db659a57dc909cb41c7eb685ae2aa9192c460867610ae68b5850856e4d6ff81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/souk/releases/download/souk-v0.1.1/souk-x86_64-apple-darwin.tar.xz"
      sha256 "ff1ca67e9cc4fc7abb4196442f991d6153ff72608aeb6b5daa9dc0c15db8484f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/souk/releases/download/souk-v0.1.1/souk-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7a641c0c56360737ac1d7db2253646197b29b00a35aaee54cd77a403f6c7344f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/souk/releases/download/souk-v0.1.1/souk-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "223367b0dcd487254287b53103771e8fac4c80451285a8d303ecb95cf35ed39c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
    bin.install "souk" if OS.mac? && Hardware::CPU.arm?
    bin.install "souk" if OS.mac? && Hardware::CPU.intel?
    bin.install "souk" if OS.linux? && Hardware::CPU.arm?
    bin.install "souk" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
