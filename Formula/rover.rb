class Rover < Formula
  desc "An MCP server for fetching and prepping web content for LLM agents."
  homepage "https://github.com/aaronbassett/rover"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.2.1/rover-fetch-aarch64-apple-darwin.tar.xz"
      sha256 "7869377878a1ca063b77e1efb6c7b9011a61b1e0631b88098342b053a89085d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.2.1/rover-fetch-x86_64-apple-darwin.tar.xz"
      sha256 "45a26cdb06fd368886ad4be45da3b5e6c13e18b915c7d524750c4467419a6b6a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.2.1/rover-fetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "473b730b45e9b58548e9f57fd617e4884968a60ed11b1c91c909ada66023ea99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.2.1/rover-fetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d8b835831354302ce2f94bb69c01f70f76049c5b215da5f00edc1e7dfefdd71"
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
