class Agentbin < Formula
  desc "CLI for publishing rendered documents at public URLs"
  homepage "https://github.com/aaronbassett/agentbin"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/agentbin/releases/download/agentbin-v0.1.1/agentbin-aarch64-apple-darwin.tar.xz"
      sha256 "f702db0463d67a4df2e5354e0931daad5a6031067b9f57300b3ff6f825582ba0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/agentbin/releases/download/agentbin-v0.1.1/agentbin-x86_64-apple-darwin.tar.xz"
      sha256 "89b4c87bdeb5b9dd38b74cc64a7223e995bfcfcf364cd6f157fae02c1c770c76"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/agentbin/releases/download/agentbin-v0.1.1/agentbin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "705a169fc7ca3e1d7c483ab227c9b353da7bc24b0f1497f3a3cdb63faad718f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/agentbin/releases/download/agentbin-v0.1.1/agentbin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5fcfa36c5e8554656b223461399340d8642526903f41ea6c7eba0b77888ba1e2"
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
    bin.install "agentbin" if OS.mac? && Hardware::CPU.arm?
    bin.install "agentbin" if OS.mac? && Hardware::CPU.intel?
    bin.install "agentbin" if OS.linux? && Hardware::CPU.arm?
    bin.install "agentbin" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
