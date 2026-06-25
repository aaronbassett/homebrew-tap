class Rover < Formula
  desc "An MCP server for fetching and prepping web content for LLM agents."
  homepage "https://github.com/aaronbassett/rover"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.3.1/rover-fetch-aarch64-apple-darwin.tar.xz"
      sha256 "79d350828b4c516d6a6cb0a9f3c431429bf081721650d67ded490f69882c8c17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.3.1/rover-fetch-x86_64-apple-darwin.tar.xz"
      sha256 "ca7414d16c23ff1209c7ce895324cbcdd8b0f7c703a9de9826b416b41b551ed1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.3.1/rover-fetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2696c6fc7266a4965ae87ce5bd160793f0b3ad7b7480a5d2dc2619fbe84b1a87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.3.1/rover-fetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a52f745c2320ac3afaa79756fe45152f8af5d6a9220501925aa0bf63152006c8"
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
