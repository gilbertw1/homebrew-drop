class Drop < Formula
  desc "A simple screenshot, screencast, and file upload tool with S3 support"
  homepage "https://github.com/gilbertw1/drop"
  url "https://github.com/gilbertw1/drop/archive/0.1.4.1.tar.gz"
  sha256 "90c1d3fa009717ae85985706c95f314917afa7aaf3a370d4cccd23e877ed2c20"
  head "https://github.com/gilbertw1/drop.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    bin.install "target/release/drop"
    man1.install "doc/drop.1"

    # Completion scripts are generated in the crate's build directory, which
    # includes a fingerprint hash. Try to locate it first
    out_dir = Dir["target/release/build/drop-*/out"].first
    bash_completion.install "#{out_dir}/drop.bash-completion"
    fish_completion.install "#{out_dir}/drop.fish"
    if build.head?
      zsh_completion.install "complete/_drop"
    else
      zsh_completion.install "#{out_dir}/_drop"
    end
  end

  test do
    system "#{bin}/drop"
  end
end
