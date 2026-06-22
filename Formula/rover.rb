class Rover < Formula
  desc "An MCP server for fetching and prepping web content for LLM agents."
  homepage "https://github.com/aaronbassett/rover"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.1.0/rover-fetch-aarch64-apple-darwin.tar.xz"
      sha256 "1f8983b9403c4645de22e5f83d2786379aa6059cded6265ffa074ab247347fa9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.1.0/rover-fetch-x86_64-apple-darwin.tar.xz"
      sha256 "a8f11a75882a6613154c6ba4b2844e56e9ec69124ae0827003213750bc7392ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aaronbassett/rover/releases/download/v0.1.0/rover-fetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bae5d5160a4805000a0ebb400b963e8a17f673328283de02d009fd0267f73679"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aaronbassett/rover/releases/download/v0.1.0/rover-fetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a875e7988586e249b9d54370bac16a5230f419360bbf53be2d747c0ca0afb1f8"
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
