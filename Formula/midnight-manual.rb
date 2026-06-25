class MidnightManual < Formula
  desc "midnight-manual CLI binary (also installed as `mnm`); exposes `mcp serve` subcommand."
  homepage "https://midnight.network"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/devrelaicom/midnight-manual/releases/download/v0.4.0/midnight-manual-aarch64-apple-darwin.tar.xz"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/devrelaicom/midnight-manual/releases/download/v0.4.0/midnight-manual-aarch64-unknown-linux-gnu.tar.xz"
    end
    if Hardware::CPU.intel?
      url "https://github.com/devrelaicom/midnight-manual/releases/download/v0.4.0/midnight-manual-x86_64-unknown-linux-gnu.tar.xz"
    end
  end
  license any_of: ["Apache-2.0", "MIT"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "midnight-manual", "mnm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "midnight-manual", "mnm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "midnight-manual", "mnm"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
