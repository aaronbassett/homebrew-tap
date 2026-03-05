class Souk < Formula
  desc "CLI tool for managing Claude Code plugin marketplaces"
  homepage "https://github.com/aaronbassett/souk"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/souk/releases/download/souk-v0.1.2/souk-aarch64-apple-darwin.tar.xz"
      sha256 "4cd159ee44e45a23aa94299e81a300b8d337a5d7b7f8ade05336575623e72179"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/souk/releases/download/souk-v0.1.2/souk-x86_64-apple-darwin.tar.xz"
      sha256 "df34b9b3e820762fc36cce609e6e05c287719ded2cb1f82ea292eca6a12a6947"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/souk/releases/download/souk-v0.1.2/souk-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "886871872fff87b4b59de6edcb0d0fead47e7c1a1bd8692b94d6eef4144d1604"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/souk/releases/download/souk-v0.1.2/souk-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ef6f2867116fef9823dc15e4a65bff86bf44d6a83966b9af945b39e9bee60bd7"
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
