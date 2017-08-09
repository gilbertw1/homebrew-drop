class Drop < Formula
  desc "A simple screenshot, screencast, and file upload tool with S3 support"
  homepage "https://github.com/gilbertw1/drop"
  url "https://github.com/gilbertw1/drop/archive/0.2.3.tar.gz"
  sha256 "d6121a0079877d1e9480d194f9eb7e58813c23edb9186be5111d68c00ca9759b"
  head "https://github.com/gilbertw1/drop.git"

  depends_on "rust" => :build
  depends_on "s3cmd" => :run

  def install
    system "cargo", "build", "--release"

    bin.install "target/release/drop"
    man1.install "doc/drop.1"

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
