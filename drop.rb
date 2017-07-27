class Drop < Formula
  desc "A simple screenshot, screencast, and file upload tool with S3 support"
  homepage "https://github.com/gilbertw1/drop"
  url "https://github.com/gilbertw1/drop/archive/0.2.2.tar.gz"
  sha256 "08aec3365138a97da3497bafb6febf7afe6fad7396982a43e626fac086f48bc9"
  head "https://github.com/gilbertw1/drop.git"

  depends_on "rust" => :build

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
