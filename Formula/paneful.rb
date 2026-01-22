class Paneful < Formula
  desc "macOS window introspection CLI tool"
  homepage "https://github.com/aaronbassett/paneful"
  version "0.1.2"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on :macos
  depends_on macos: :sonoma

  on_arm do
    url "https://github.com/aaronbassett/paneful/releases/download/v0.1.2/paneful-v0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "c3dbed0ef47b9d0fd030dabe80b59c0209d064be09fa50ab53b75c6f53f12ce1"
  end

  on_intel do
    url "https://github.com/aaronbassett/paneful/releases/download/v0.1.2/paneful-v0.1.2-x86_64-apple-darwin.tar.gz"
    sha256 "2ce9ee953f246651fa432db2ec37005b5a9bf36b73feaf59ddcb04363a130c46"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "paneful"
    man1.install "man/paneful.1"
    bash_completion.install "completions/paneful.bash" => "paneful"
    zsh_completion.install "completions/paneful.zsh" => "_paneful"
    fish_completion.install "completions/paneful.fish"
  end

  def caveats
    <<~EOS
      paneful requires Screen Recording permission to access window metadata.

      Grant permission at:
        System Settings → Privacy & Security → Screen Recording

      Add your terminal app (Terminal, iTerm2, etc.) to the allowed list.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/paneful --version")
  end
end
