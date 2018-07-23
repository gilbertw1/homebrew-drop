class Drop < Formula
  desc "A simple screenshot, screencast, and file upload tool with S3 support"
  homepage "https://github.com/gilbertw1/drop"
  url "https://github.com/gilbertw1/drop/archive/0.2.8.tar.gz"
  sha256 "21a98e24b0fbb88fe9c2fd27122713f38fa16f7f50b35f2b42e731af54a463c2"
  head "https://github.com/gilbertw1/drop.git"

  depends_on "rust"
  depends_on "s3cmd"

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
